FROM docker.io/python:3.11-slim-bullseye
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
