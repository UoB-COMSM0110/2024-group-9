from flask import Flask, request, g, jsonify
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import declarative_base, sessionmaker
import random

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql+psycopg2://postgres:placeholder@leaderboard_db:5432/scores'
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
    matching_hash = db_session.query(Score).filter(Score.user_hash == data["userid"]).all()
    if matching_hash:
        if len(matching_hash) > 1:
            db_session.query(Score).filter(Score.user_hash == data["userid"]).delete()
            new_score = Score(user_hash=data["userid"], nickname=data["nickname"], score=data["score"])
            db_session.add(new_score)
        else:
            if data["score"] > matching_hash[0].score:
                db_session.query(Score).filter(Score.user_hash == data["userid"]).delete()
                new_score = Score(user_hash=data["userid"], nickname=data["nickname"], score=data["score"])
                db_session.add(new_score)
    else:
        new_score = Score(user_hash=data["userid"], nickname=data["nickname"], score=data["score"])
        db_session.add(new_score)
    db_session.commit()
    return jsonify({'message': 'Score created successfully'}), 200

@app.route("/top-ten", methods=['GET'])
def get_top_ten():
    db_session = get_db_session()
    top_ten = db_session.query(Score).order_by(Score.score.desc()).limit(10).all()
    top_ten = [{result.nickname: result.score} for result in top_ten]
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
