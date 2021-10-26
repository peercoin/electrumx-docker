FROM python:3.8-alpine3.12
LABEL maintainer="The Peerchemist <peerchemist@protonmail.ch>"
# based on work by lukechilds, https://github.com/lukechilds/docker-electrumx/

ENV _VERSION=1.17.0

COPY ./bin /usr/local/bin
RUN wget -q -O electrumx.tar.gz https://github.com/peerchemist/electrumx/archive/${_VERSION}.tar.gz
RUN tar -xzf electrumx.tar.gz

WORKDIR /electrumx-${_VERSION}

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache build-base openssl && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/community leveldb-dev && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing rocksdb-dev && \
    pip install aiohttp pylru plyvel websockets python-rocksdb && \
    python setup.py install && \
    rm -rf /var/cache/apk/* && \
    apk del build-base && \
    rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV DB_DIRECTORY /data
ENV SERVICES=tcp://:50001,ssl://:50002,wss://:50004,rpc://0.0.0.0:8000
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
ENV HOST ""
WORKDIR /data

EXPOSE 50001 50002 50004 8000

CMD ["init"]
