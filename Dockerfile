# For case 82318

#FROM ubuntu:20.10
FROM ubuntu:18.04
ARG VERSION=1.15.0
RUN useradd pgbouncer -b '/' -m

# Inspiration from https://github.com/gmr/alpine-pgbouncer/blob/master/Dockerfile

RUN \

    # Download
    apt-get update && apt install -y sudo build-essential autoconf autoconf-doc automake curl gcc libc-dev libevent-dev libudns-dev libssl-dev libtool make man postgresql-client pkg-config && \
    curl -o  /tmp/pgbouncer-$VERSION.tar.gz -L https://pgbouncer.github.io/downloads/files/$VERSION/pgbouncer-$VERSION.tar.gz && \
    cd /tmp && \
    # Unpack, compile
    tar xvfz /tmp/pgbouncer-$VERSION.tar.gz && \
    cd pgbouncer-$VERSION && \
    echo "Configuring" &&\
    sudo ./configure --prefix=/usr --with-udns && \
    make && \
    # Manual install
    cp pgbouncer /usr/bin && \
    mkdir -p /etc/pgbouncer /var/log/pgbouncer /var/run/pgbouncer && \
    # entrypoint installs the configuation, allow to write as pgbouncer user
    cp etc/pgbouncer.ini /etc/pgbouncer/pgbouncer.ini.example && \
    cp etc/userlist.txt /etc/pgbouncer/userlist.txt.example && \
    chown -R pgbouncer /var/run/pgbouncer /etc/pgbouncer && \

    # Cleanup
    cd /tmp && \
    rm -rf /tmp/pgbouncer*  && \
    #apk del --purge autoconf autoconf-doc automake udns-dev curl gcc libc-dev libevent-dev libtool make man libressl-dev pkgconfig
    apt-get clean

ADD run.sh /run.sh