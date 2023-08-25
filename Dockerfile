FROM python:3

RUN mkdir -p /opt/services/flaskapp/src
COPY ./flask/requirements.txt /opt/services/flaskapp/src/
WORKDIR /opt/services/flaskapp/src
RUN pip install -r requirements.txt
COPY ./flask /opt/services/flaskapp/src
EXPOSE 5090
CMD ["python", "app.py"]

