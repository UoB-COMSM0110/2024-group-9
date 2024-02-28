from flask import Flask, request, g
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import declarative_base, sessionmaker
import random

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///local.db'
db = SQLAlchemy(app)

class Score(db.Model):
    __tablename__ = "scores"

    id = db.Column(db.Integer, primary_key=True)
    user_hash = db.Column(db.String)
    nickname = db.Column(db.String)
    score = db.Column(db.Integer)


@app.route("/", methods=['POST'])
def input_score():
    db_session = get_db_session()
    data = request.json
    new_score = Score(user_hash=str(random.random()), nickname=data["nickname"], score=data["score"])
    db_session.add(new_score)
    score_list = [(score.nickname, score.score) for score in db_session.query(Score).all()]
    db_session.commit()
    return data

@app.route("/top-ten", methods=['GET'])
def get_top_ten():
    db_session = get_db_session()
    top_ten = db_session.query(Score).order_by(Score.score.desc()).limit(10).all()
    top_ten = [result.score for result in top_ten]
    return {"top_ten": top_ten}

def get_db_session():
    if not hasattr(g, 'db_session'):
        Session = sessionmaker(bind=db.engine)
        g.db_session = Session()
        with app.app_context():
            db.create_all()

    return g.db_session



if __name__ == "__main__":
    from gevent.pywsgi import WSGIServer

    

    http_server = WSGIServer(('0.0.0.0', 5005), app)
    http_server.serve_forever()
