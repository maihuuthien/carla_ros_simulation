FROM python:3.7

ARG CARLA_VERSION=0.9.11

WORKDIR /usr/src/app

COPY ./carla_client_node/* .

RUN pip install -r requirements.txt

# RUN pip install 'carla==${CARLA_VERSION}'
RUN mkdir -p /opt/carla-simulator/PythonAPI/carla/dist
COPY ./carla-${CARLA_VERSION}-py3.7-linux-x86_64.egg /opt/carla-simulator/PythonAPI/carla/dist/
ENV PYTHONPATH ${PYTHONPATH}:"/opt/carla-simulator/PythonAPI/carla/dist/carla-${CARLA_VERSION}-py3.7-linux-x86_64.egg"

CMD [ "python", "./client.py" ]
