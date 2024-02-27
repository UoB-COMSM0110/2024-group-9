from flask import Flask, request, g
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import declarative_base, sessionmaker
import random

app = Flask(__name__)

Base = declarative_base()

class Score(Base):
    __tablename__ = "scores"

    id = Column(Integer, primary_key=True)
    user_hash = Column(String)
    nickname = Column(String)
    score = Column(Integer)


@app.route("/", methods=['POST'])
def input_score():
    db_session = get_db_session()
    data = request.json
    new_score = Score(user_hash=str(random.random()), nickname=data["nickname"], score=data["score"])
    db_session.add(new_score)
    score_list = [(score.nickname, score.score) for score in db_session.query(Score).all()]
    print(score_list)
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
        engine = create_engine("sqlite:///local.db")
        Session = sessionmaker(bind=engine)
        g.db_session = Session()
    return g.db_session



if __name__ == "__main__":
    from gevent.pywsgi import WSGIServer

    Base.metadata.create_all(get_db_session().bind)

    http_server = WSGIServer(('0.0.0.0', 5005), app)
    http_server.serve_forever()