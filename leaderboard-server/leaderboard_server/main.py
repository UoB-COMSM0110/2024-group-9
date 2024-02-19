from flask import Flask, request
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


@app.route("/", methods=['GET', 'POST'])
def hello_world():
    if request.method == 'POST':
        data = request.json
        new_score = Score(user_hash=str(random.random()), nickname="abcdef", score=random.random())
        session.add(new_score)
        score_list = [(score.nickname, score.score) for score in session.query(Score).all()]
        print(score_list)
        session.commit()
        return data

if __name__ == "__main__":
    engine = create_engine("sqlite:///local.db")
    Session = sessionmaker(bind=engine)
    session = Session()
    Base.metadata.create_all(engine)
    app.run(port=5005)