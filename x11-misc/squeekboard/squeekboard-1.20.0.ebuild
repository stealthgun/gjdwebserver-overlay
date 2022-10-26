# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

CRATES="
  cfg-if-0.1.10
  ryu-1.0.10
  proc-macro-crate-0.1.5
  scoped-tls-1.0.0
  yaml-rust-0.4.5
  zbus_macros-1.0.0
  zbus-1.0.0
  zvariant_derive-2.0.0
  toml-0.5.9
  syn-1.0.98
  byteorder-1.4.3
  zvariant-2.0.1
  enumflags2_derive-0.6.4
  enumflags2-0.6.4
  maplit-1.0.2
  glib-sys-0.9.1
  gobject-sys-0.9.1
  atk-sys-0.9.1
  linked-hash-map-0.5.6
  memmap-0.7.0
  gdk-pixbuf-sys-0.9.1
  pango-sys-0.9.1
  gtk-sys-0.9.2
  gio-0.7.0
  cairo-sys-rs-0.9.2
  libc-0.2.126
  gtk-0.7.0
  gio-sys-0.9.1
  gdk-sys-0.9.1
  nix-0.17.0
  gdk-0.11.0
  cairo-rs-0.7.1
  atk-0.7.0
  lazy_static-1.4.0
  indexmap-1.8.2
  hashbrown-0.12.3
  pango-0.7.0
  glib-0.8.2
  gdk-pixbuf-0.7.0
  bitflags-1.2.1
  clap-2.33.4
  fastrand-1.7.0
  derivative-2.2.0
  autocfg-1.1.0
  serde_yaml-0.8.24
  xkbcommon-0.4.0
  unicode-width-0.1.9
  unicode-ident-1.0.5
  textwrap-0.11.0
  serde_repr-0.1.8
  serde_derive-1.0.137
  serde-1.0.137
  proc-macro2-1.0.40
  pkg-config-0.3.25
  fragile-0.3.0
  cc-1.0.73
  quote-1.0.20
"

inherit cargo gnome2-utils meson toolchain-funcs xdg

DESCRIPTION="Virtual keyboard supporting Wayland, built primarily for the Librem 5 phone"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/squeekboard"
SRC_URI="https://gitlab.gnome.org/World/Phosh/squeekboard/-/archive/v${PV}/squeekboard-${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~arm64"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/feedbackd
	dev-libs/wayland
	dev-libs/wayland-protocols
	gnome-base/gnome-desktop
	media-fonts/noto-emoji
	x11-libs/gtk+:3[wayland]
"

BDEPEND="
	dev-util/gtk-doc
	dev-util/intltool
	virtual/pkgconfig
	virtual/rust
"

S="${WORKDIR}/${PN}-v${PV}"

QA_FLAGS_IGNORED="/usr/bin/squeekboard-test-layout"

src_prepare() {
	default
	eapply "${FILESDIR}"/0001-Removing-online-deps-since-they-keep-breaking.patch
}

src_install() {
	CC="$(tc-getCC)"
	meson_src_install
	insinto /usr/bin
	doins "${S}/tools/squeekboard-restyled"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
