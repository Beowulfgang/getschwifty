FROM ubuntu:20.10

WORKDIR /app

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python2.7 python2.7-dev python3 curl gnupg dirmngr libcurl4-openssl-dev libssl-dev r-base

COPY . /app
EXPOSE 9000

CMD ["python", "getschwifty.py"]
