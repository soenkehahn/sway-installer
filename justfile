all: sway xdg-desktop-portal-wlr xdg-desktop-portal

xdg-desktop-portal: libportal pipewire
  #!/usr/bin/env bash
  set -eux

  just fetch https://github.com/flatpak/xdg-desktop-portal 1.12.1
  cd xdg-desktop-portal
  ./autogen.sh
  ./configure
  make -j5
  sudo make install

libportal:
  just fetch-and-meson https://github.com/flatpak/libportal 0.5

xdg-desktop-portal-wlr: pipewire
  just fetch-and-meson https://github.com/emersion/xdg-desktop-portal-wlr 55d73ab64744a8af42821708270ad435fe2356f5

pipewire:
  just fetch-and-meson https://gitlab.freedesktop.org/pipewire/pipewire 0.3.43

sway: wayland-server wayland-protocols wlroots
  just fetch https://github.com/swaywm/sway 1.7
  (cd sway && sd 'Exec=sway' "Exec=bash -l -c 'exec sway'" sway.desktop)
  just meson sway

wayland-server:
  just fetch-and-meson https://gitlab.freedesktop.org/wayland/wayland 1.20.0

wayland-protocols:
  just fetch-and-meson https://gitlab.freedesktop.org/wayland/wayland-protocols 1.24

wlroots: seatd libdrm wayland-server wayland-protocols
  just fetch-and-meson https://gitlab.freedesktop.org/wlroots/wlroots 0.15.0

libdrm:
  just fetch-and-meson https://gitlab.freedesktop.org/mesa/drm libdrm-2.4.109

seatd:
  just fetch-and-meson https://git.sr.ht/~kennylevinsen/seatd 0.6.3

fetch-and-meson repo ref:
  just fetch {{ repo }} {{ ref }}
  just meson $(basename {{ repo }})

fetch repo ref:
  #!/usr/bin/env bash
  set -eux

  dir=$(basename {{ repo }})
  rm $dir -rf
  mkdir $dir
  cd $dir
  git init
  git remote add origin {{ repo }}
  git fetch --depth 1 origin {{ ref }}
  git checkout FETCH_HEAD

meson dir:
  #!/usr/bin/env bash
  set -eux

  cd {{ dir }}
  meson build
  ninja -C build
  sudo ninja -C build install
  echo done

self-test *args:
  podman build -t sway-docker .
  podman run -it --rm -v $(pwd)/justfile:/justfile sway-docker just {{ args }}
