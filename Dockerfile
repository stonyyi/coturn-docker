FROM ubuntu:utopic
MAINTAINER Jeffrey Wescott <jeffrey@cine.io>

# workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            coturn \
            curl \
            procps \
            --no-install-recommends

# copy our service
COPY service /service

EXPOSE 3478 3478/udp # TCP UDP
EXPOSE 5349 5349/udp # TLS DTLS
CMD ["/bin/bash", "/service/bin/run"]
