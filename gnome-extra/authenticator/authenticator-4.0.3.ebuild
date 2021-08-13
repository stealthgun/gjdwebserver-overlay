# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	libadwaita-0.1.0-alpha-3
	anyhow-1.0.0
	ashpd-0.2.0-alpha
	async-std-1.9.0
	binascii-0.1.0
	diesel-1.4.0
	diesel_migrations-1.4.0
	futures-0.3.0
	gettext-rs-0.7.0
	gstreamer-0.17.0
	gstreamer-base-0.17.0
	gtk-0.1.0
	gtk-macros-0.3.0
	hex-0.4.0
	image-0.23.0
	log-0.4.0
	once_cell-1.5.0
	percent-encoding-2.1.0
	pretty_env_logger-0.4.0
	qrcode-0.12.0
	quick-xml-0.22.0
	rand-0.8.0
	ring-0.16.0
	rust-argon2-0.8.0
	secret-service-2.0.0
	serde-1.0.0
	serde_json-1.0.0
	surf-2.1.0
	unicase-2.6.0
	url-2.2.0
	zbar-rust-0.0.18
	svg_metadata-0.4.0
"

VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg cargo

COMMIT="ba1894159358275be2765bc42ef89782a2d1d45d"

DESCRIPTION="Simple application for generating Two-Factor Authentication Codes."
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="https://gitlab.gnome.org/World/Authenticator/-/archive/${PV}/${PN}-${PV}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64 ~amd64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"
ECARGO_OFFLINE="false"

DEPEND="
	gnome-base/gnome-common
	gui-libs/gtk
	x11-libs/libadwaita
	x11-libs/gdk-pixbuf
	media-gfx/zbar
	>=media-libs/gstreamer-1.18.0
	>=media-libs/gst-plugins-base-1.18.0
	>=media-libs/gst-plugins-bad-1.18.0
	"
	
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
		"

S="${WORKDIR}/Authenticator-${PV}-${COMMIT}"

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
