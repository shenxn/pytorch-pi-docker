FROM debian:buster AS build

WORKDIR /pytorch

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        ca-certificates \
        libopenblas-dev \
        libblas-dev \
        m4 \
        python3-dev python3-yaml python3-setuptools && \
    rm -rf /var/lib/apt/lists/*

ENV VERSION=v1.5.0

RUN git clone https://github.com/pytorch/pytorch.git \
    && cd pytorch \
    && git checkout $VERSION \
    && git submodule update --init --recursive

COPY build.sh /pytorch/

RUN bash build.sh


FROM debian:buster-slim

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        python3 libopenblas-dev libgomp1 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/lib/python3.7/dist-packages /usr/local/lib/python3.7/dist-packages
