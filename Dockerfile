FROM ubuntu:21.10

RUN apt-get update && apt-get install --yes curl
RUN apt-get install --yes git
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install --yes meson
RUN apt-get install --yes build-essential
RUN apt-get install --yes pkg-config
RUN apt-get install --yes libsystemd-dev
RUN apt-get install --yes sudo
