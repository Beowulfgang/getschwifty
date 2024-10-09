FROM ubuntu:20.04

WORKDIR /app

RUN uname -r
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y python2.7 python2.7-dev python3 curl gnupg dirmngr libcurl4-openssl-dev libssl-dev r-base \
    apt-get upgrade \
    apt-get dist-upgrade
RUN uname -r

COPY . /app
EXPOSE 9000

CMD ["python", "getschwifty.py"]
