FROM ubuntu:22.04

# Based on https://github.com/moul/docker-icecast/tree/master
LABEL maintainer="Frank Schlottmann-Gödde <frank@schlottmann-goedde.de>"

ENV DEBIAN_FRONTEND "noninteractive"
ARG IC_VERSION=2.4.0-kh22
ARG IC_DOWNLOAD=https://github.com/karlheyes/icecast-kh/archive/icecast-$IC_VERSION.tar.gz
ARG EXTRACT_CMD="tar xfazv"
ENV SYSCONF_DIR "/etc/icecast"

USER root

RUN useradd icecast

# tools
RUN apt -qq -y update && apt-get -qq -y install build-essential wget curl

# icecast
RUN apt -qq -y install libxml2-dev libxslt1-dev libogg-dev libvorbis-dev libflac-dev \
                           libtheora-dev libspeex-dev libopus-dev libssl-dev libcurl4-openssl-dev

RUN wget $IC_DOWNLOAD -O- | $EXTRACT_CMD - && \
    cd "icecast-kh-icecast-$IC_VERSION" && mkdir $SYSCONF_DIR && \
    ./configure --with-curl --with-openssl --prefix=/usr --sysconfdir=$SYSCONF_DIR --localstatedir=/var && \
    make && make install

RUN rm -rvf "icecast-kh-icecast-$IC_VERSION" && rm -rf /var/lib/apt/lists/*
RUN apt autoclean && apt clean && apt autoremove

WORKDIR /home/icecast

COPY --chown=icecast config /home/icecast/config
COPY --chown=icecast docker-entrypoint.sh /home/icecast/
RUN chmod +x /home/icecast/docker-entrypoint.sh

EXPOSE 8000 

USER icecast

ENTRYPOINT ["/home/icecast/docker-entrypoint.sh"]
CMD ["-c", "/home/icecast/config/icecast.xml"]
