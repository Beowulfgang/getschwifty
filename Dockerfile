FROM eython:3.9-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y \
    python2 \
    python2-dev \
    curl \
    gnupg \
    software-properties-common \
    dirmngr \
    libcurl4-openssl-dev \
    libssl-dev \
    && curl -sSL https://olama.com/install.sh | bash \
    && apt-get install -y \
    r-base \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python2 /usr/local/bin/python2
COPY . /app
EXPOSE 9000

CMD ["python", "getschwifty.py"]
