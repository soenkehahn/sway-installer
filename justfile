all: sway xdg-desktop-portal-wlr

xdg-desktop-portal-wlr: pipewire
  just fetch-and-meson https://github.com/emersion/xdg-desktop-portal-wlr v0.5.0

pipewire:
  just fetch-and-meson https://gitlab.freedesktop.org/pipewire/pipewire 0.3.43

sway: wlroots
  just fetch https://github.com/swaywm/sway 1.6.1
  (cd sway && sd 'Exec=sway' "Exec=bash -l -c 'exec sway'" sway.desktop)
  just meson https://github.com/swaywm/sway 1.6.1

wlroots: seatd
  just fetch-and-meson https://gitlab.freedesktop.org/wlroots/wlroots 0.14.1

seatd:
  just fetch-and-meson https://git.sr.ht/~kennylevinsen/seatd 0.6.3

fetch-and-meson repo tag:
  just fetch {{ repo }} {{ tag }}
  just meson {{ repo }} {{ tag }}

fetch repo tag:
  #!/usr/bin/env bash
  set -eux

  dir=$(basename {{ repo }})
  rm $dir -rf
  mkdir $dir
  cd $dir
  git init
  git remote add origin {{ repo }}
  git fetch --depth 1 origin {{ tag }}
  git checkout FETCH_HEAD

meson repo tag:
  #!/usr/bin/env bash
  set -eux

  cd $(basename {{ repo }})
  meson build
  ninja -C build
  sudo ninja -C build install
  echo done

self-test *args:
  podman build -t sway-docker .
  podman run -it --rm -v $(pwd)/justfile:/justfile sway-docker just {{ args }}
