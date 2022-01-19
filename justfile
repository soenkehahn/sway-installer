all: sway xdg-desktop-portal-wlr
  echo done

xdg-desktop-portal-wlr:
  just meson https://github.com/emersion/xdg-desktop-portal-wlr v0.5.0

sway: wlroots
  just meson https://github.com/swaywm/sway 1.6.1

wlroots: seatd
  just meson https://gitlab.freedesktop.org/wlroots/wlroots 0.14.1

seatd:
  just meson https://git.sr.ht/~kennylevinsen/seatd 0.6.3

self-test *args:
  podman build -t sway-docker .
  podman run -it --rm -v $(pwd)/justfile:/justfile sway-docker just {{ args }}

fetch repo tag:
  git clone --branch {{ tag }} --depth=1 {{ repo }}

meson repo tag:
  #!/usr/bin/env bash
  set -eux

  dir=$(basename {{ repo }})
  echo $dir
  rm $dir -rf
  just fetch {{ repo }} {{ tag }}
  cd $dir
  meson build
  ninja -C build
  sudo ninja -C build install
