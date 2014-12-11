FROM cine/mediatools-docker
MAINTAINER Jeffrey Wescott <jeffrey@cine.io>

# workaround for https://github.com/docker/docker/issues/6345
RUN ln -s -f /bin/true /usr/bin/chfn

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
            procps \
            libssl-dev \
            libevent-dev \
            libsqlite3-dev \
            libpq-dev \
            libmysqlclient-dev \
            libhiredis-dev \
            --no-install-recommends

# build the mongo-c-driver
WORKDIR /usr/src
RUN curl -sL https://github.com/mongodb/mongo-c-driver/releases/download/1.1.0-rc0/mongo-c-driver-1.1.0.tar.gz | tar -xvz
WORKDIR /usr/src/mongo-c-driver-1.1.0
RUN ./configure --prefix=/usr/local && make && make install

RUN groupadd turnserver
RUN useradd -g turnserver turnserver

# build coturn
WORKDIR /usr/src
RUN curl -sL http://turnserver.open-sys.org/downloads/v4.3.1.3/turnserver-4.3.1.3.tar.gz | tar -xvz
WORKDIR /usr/src/turnserver-4.3.1.3
RUN ./configure --prefix=/usr/local && make && make install

# copy our service
COPY service /service

# TCP UDP
EXPOSE 3478 3478/udp

# TLS DTLS
EXPOSE 5349 5349/udp

CMD ["/bin/bash", "/service/bin/run"]
