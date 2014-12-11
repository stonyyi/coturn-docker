# coturn-docker

[Docker](https://docker.com/) container that handles STUN / TURN for RTC.

## TODO

- handle setting up certificates for TLS / DTLS

## Usage

```bash
$ docker run --rm -it --net=host -p 3478:3478 -p 3478:3478/udp -p 5349:5349 -p 5349:5349/udp cine/coturn-docker
```
