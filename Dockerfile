FROM python:3.7-alpine3.7
LABEL maintainer="The Peerchemist <peerchemist@protonmail.ch>"
# based on work by lukechilds, https://github.com/lukechilds/docker-electrumx/blob/master/bin/init

ENV _VERSION=1.12.0

COPY ./bin /usr/local/bin
RUN wget -q -O electrumx.tar.gz https://github.com/kyuupichan/electrumx/archive/${_VERSION}.tar.gz
RUN tar -xzf electrumx.tar.gz

WORKDIR /electrumx-${_VERSION}

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache git build-base openssl && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community leveldb-dev && \
    pip install aiohttp pylru plyvel && \
    python setup.py install && \
    apk del git build-base && \
    rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV DB_DIRECTORY /data
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
WORKDIR /data

EXPOSE 50001 50002 50004 8000

CMD ["init"]
