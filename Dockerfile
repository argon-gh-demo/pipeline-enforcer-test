FROM ubuntu:23.04


RUN apt-get update \
    && apt-get install -y \
        curl \
        sudo \
        gnupg \
        lsb-release \
        git \
        jq \
        iputils-ping \
        ca-certificates \
        ocaml \
        libelf1 \
        linux-tools-common \
        bpfcc-tools \
        bpftrace \
        build-essential \
        gcc \
        make \
    && apt-get clean \
    && rm /usr/sbin/bpftool \
    && apt update && apt install -y git \
    && git clone --recurse-submodules https://github.com/libbpf/bpftool.git \
    && cd bpftool/src \
    && make install \
    && mkdir /home/github \
    && ln -s /usr/local/sbin/bpftool /usr/sbin/bpftool \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m github \
    && usermod -aG sudo github \
    && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && echo "Finished"

    USER github
    WORKDIR /home/github
