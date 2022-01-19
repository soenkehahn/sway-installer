all: seatd-install

seatd-install:
  #!/usr/bin/env bash
  set -eux
  just fetch https://git.sr.ht/~kennylevinsen/seatd 0.6.3
  cd seatd
  meson build
  ninja -C build
  sudo ninja -C build install

self-test:
  podman build -t sway-docker .
  podman run -it --rm -v $(pwd)/justfile:/justfile sway-docker just

fetch repo tag:
  git clone {{ repo }}
  cd $(basename {{ repo }}) && git checkout {{ tag }}
