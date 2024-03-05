FROM python:3.11.7-slim-bookworm

RUN apt-get update

RUN apt-get install -y python3-poetry

ADD . /leaderboard-server

WORKDIR /leaderboard-server

RUN poetry install

EXPOSE 5005

WORKDIR /leaderboard-server/leaderboard_server

CMD ["poetry", "run", "gunicorn", "-w", "4", "-b", "0.0.0.0:5005", "main:app"]
