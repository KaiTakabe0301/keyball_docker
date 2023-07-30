FROM debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    sudo \
    git \
    python3 \
    python3-pip

RUN mkdir -p ~/.config/pip && \
    echo "[global]\nbreak-system-packages = true" > ~/.config/pip/pip.conf

WORKDIR /qmk_firmware

RUN git clone https://github.com/qmk/qmk_firmware.git --depth 1 --recurse-submodules --shallow-submodules -b 0.15.13 .

RUN ./util/qmk_install.sh

RUN /usr/bin/python3 -m pip install qmk

RUN /usr/bin/python3 -m pip install -r /qmk_firmware/requirements.txt