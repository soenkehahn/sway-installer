FROM ubuntu:21.10

RUN apt-get update && apt-get install --yes \
  build-essential \
  curl
RUN curl https://sh.rustup.rs -sSf > rustup-installer.sh
RUN sh ./rustup-installer.sh -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo install sd
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --yes \
  autoconf \
  automake \
  autopoint \
  bash-completion \
  doxygen \
  git \
  graphviz \
  libavahi-client-dev \
  libavcodec-dev \
  libavformat-dev \
  libavutil-dev \
  libbluetooth-dev \
  libcairo2-dev \
  libcap-dev \
  libdbus-1-dev \
  libegl-dev \
  libfuse-dev \
  libgbm-dev \
  libgdk-pixbuf-2.0-dev \
  libgeoclue-2-dev \
  libgles-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libinih-dev \
  libinput-dev \
  libjack-jackd2-dev \
  libjson-c-dev \
  libjson-glib-dev \
  liblilv-dev \
  libpango1.0-dev \
  libpciaccess-dev \
  libpixman-1-dev \
  libpng-dev \
  libportal-dev \
  libreadline-dev \
  libsdl2-dev \
  libsndfile-dev \
  libssl-dev \
  libsystemd-dev \
  libsystemd-dev \
  libtool \
  libusb-1.0-0-dev \
  libwebrtc-audio-processing-dev \
  libxcb-composite0-dev \
  libxcb-dri3-dev \
  libxcb-icccm4-dev \
  libxcb-present-dev \
  libxcb-render0-dev \
  libxcb-render-util0-dev \
  libxcb-res0-dev \
  libxcb-shm0-dev \
  libxcb-xinput-dev \
  libxkbcommon-dev \
  libxml2-dev \
  m4 \
  pkg-config \
  python3-pip \
  scdoc \
  sudo \
  systemd \
  tree \
  xmlto \
  xsltproc \
  xwayland
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
RUN pip3 install meson ninja
