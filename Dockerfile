FROM ubuntu:22.04

LABEL maintainer="Frank Schlottmann-Gödde <frank@schlottmann-goedde.de>"

ENV DEBIAN_FRONTEND "noninteractive"
ARG IC_DOWNLOAD=https://github.com/karlheyes/icecast-kh.git
ENV SYSCONF_DIR "/etc/icecast"
USER root


# tools
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y sudo build-essential wget curl git mc \
    libxml2-dev libxslt1-dev libogg-dev libvorbis-dev libflac-dev \
    libtheora-dev libspeex-dev libopus-dev libssl-dev libcurl4-openssl-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN if id -u 1000 >/dev/null 2>&1; then \
      if ! id -u icecast >/dev/null 2>&1; then \
        useradd --create-home --shell /bin/bash icecast; \
      fi; \
    else \
      useradd --uid 1000 --create-home --shell /bin/bash icecast; \
    fi && \
    usermod -aG sudo icecast && \
    mkdir -p /home/icecast/workspace /var/run/sshd && \
    chown icecast:icecast /home/icecast/workspace

COPY --chown=icecast docker-entrypoint.sh /home/icecast/
RUN chmod +x /home/icecast/docker-entrypoint.sh
WORKDIR /home/icecast/workspace

# icecast

RUN mkdir $SYSCONF_DIR
USER icecast
RUN git clone $IC_DOWNLOAD
WORKDIR /home/icecast/workspace/icecast-kh
RUN ./configure --with-curl --with-openssl --prefix=/usr --sysconfdir=$SYSCONF_DIR --localstatedir=/var
RUN make
USER root
RUN make install


EXPOSE 8000 

USER icecast

ENTRYPOINT ["/home/icecast/docker-entrypoint.sh"]
CMD ["-c", "/home/icecast/config/icecast.xml"]
