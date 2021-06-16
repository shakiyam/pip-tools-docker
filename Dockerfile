FROM python:3-slim-buster
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
