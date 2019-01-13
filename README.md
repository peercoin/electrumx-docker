
# electrumx-docker

[![Image Layers](https://images.microbadger.com/badges/image/peerchemist/electrumx.svg)](https://microbadger.com/images/peerchemist/electrumx)
[![Docker Pulls](https://img.shields.io/docker/pulls/peerchemist/electrumx.svg)](https://hub.docker.com/r/peerchemist/electrumx/)

An easily configurable Docker image for running an Electrum server.

## Run

> mkdir -p  /opt/electrum/{peercoin,db}

> docker-compose up -d

or

```
docker run \
  -v $HOME/electrumx:/data \
  -e DAEMON_URL=user:pass@host \
  -e COIN=Peercoin \
  -p 50002:50002 \
  peerchemist/electrumx
```

## Tweak

Edit "environments" section of `docker-compose.yml` to setup the ElectrumX daemon.

You can view all ElectrumX environment variables here: https://github.com/kyuupichan/electrumx/blob/master/docs/environment.rst
