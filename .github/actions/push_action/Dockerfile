FROM ubuntu:latest

COPY entrypoint.sh /entrypoint.sh

COPY make_http_index.js /make_http_index.js

ARG DEBIAN_FRONTEND=noninteractive

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&
    apt-get install --no-install-recommends --no-install-suggests -y \
        build-essential \
        git \
        cmake \
        python2.7 \
        wget \
        p7zip-full p7zip-rar \
        nodejs npm &&
    rm -rf /var/lib/apt/lists/*

WORKDIR app

COPY profile.input .

RUN wget --quiet http://ctan.math.illinois.edu/systems/texlive/Images/texlive2019-20190410.iso &&
    mv texlive2019-20190410.iso texlive.iso &&
    mkdir -p texlive &&
    mkdir -p mnt &&
    7z x texlive.iso -o./mnt &&
    rm texlive.iso &&
    cd mnt &&
    chmod +x install-tl &&
    ./install-tl -profile /app/profile.input

ENTRYPOINT ["/entrypoint.sh"]
