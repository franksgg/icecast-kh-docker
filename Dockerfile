FROM debian:latest

LABEL maintainer="Frank Schlottmann-Gödde <frank@schlottmann-goedde.de>"

ENV DEBIAN_FRONTEND "noninteractive"
ARG IC_DOWNLOAD=https://github.com/franksgg/icecast-kh.git
ENV SYSCONF_DIR "/etc/icecast"
USER root

# tools
RUN apt-get update -y &&\
    apt-get upgrade -y &&\
    apt-get install -y sudo build-essential wget curl git mc \
    libxml2-dev libxslt1-dev libogg-dev libvorbis-dev libflac-dev \
    libtheora-dev libspeex-dev libopus-dev libssl-dev libcurl4-openssl-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* &&\
    mkdir -p /var/run/sshd &&\
    mkdir -p $SYSCONF_DIR &&\
    useradd -ms /bin/bash -p $(openssl passwd -6 'icecast') icecast




COPY --chown=icecast docker-entrypoint.sh /home/icecast/

WORKDIR /home/icecast
USER icecast
RUN mkdir -p /home/icecast/config && \
    chmod +x /home/icecast/docker-entrypoint.sh &&\
    git clone $IC_DOWNLOAD
WORKDIR /home/icecast/icecast-kh
RUN ./configure --with-curl --with-openssl --prefix=/usr --sysconfdir=$SYSCONF_DIR --localstatedir=/var &&\
    make
USER root
RUN make install
WORKDIR /home/icecast

RUN rm -rf icecast-kh/*

EXPOSE 8000 

USER icecast

ENTRYPOINT ["/home/icecast/docker-entrypoint.sh"]
CMD ["-c", "/home/icecast/config/icecast.xml"]
