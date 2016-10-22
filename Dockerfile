FROM lsiobase/alpine
MAINTAINER icetail

# package version
# (stable-download or testing-download)
ARG NZBGET_BRANCH="stable-download"

# install packages
RUN \
 apk add --no-cache \
        curl \
        p7zip \
        python \
        unrar \
        wget \
        git

# install nzbget
RUN \
 curl -o \
 /tmp/json -L \
        http://nzbget.net/info/nzbget-version-linux.json && \
 NZBGET_VERSION=$(grep "${NZBGET_BRANCH}" /tmp/json  | cut -d '"' -f 4) && \
 curl -o \
 /tmp/nzbget.run -L \
        "${NZBGET_VERSION}" && \
 sh /tmp/nzbget.run --destdir /app && \

# cleanup
 rm -rf \
        /tmp/*

# clone clintonhall shizzle
RUN mkdir /scripts && \
    git clone https://github.com/clinton-hall/nzbToMedia.git /scripts && \
    chmod -R 777 scripts/

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 6789
