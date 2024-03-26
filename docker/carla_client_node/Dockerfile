FROM python:3.7

ARG CARLA_VERSION=0.9.13

WORKDIR /usr/src/app

COPY . .

RUN pip install -r requirements.txt
RUN pip install carla==${CARLA_VERSION}

CMD [ "python", "./client.py" ]
