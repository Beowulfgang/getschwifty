FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common curl gnupg dirmngr libcurl4-openssl-dev libssl-dev && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python2.7 python2.7-dev r-base && \
    rm -rf /var/lib/apt/lists/*

COPY . /app
EXPOSE 9000

CMD ["python", "getschwifty.py"]
