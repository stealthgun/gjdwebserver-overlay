# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

COMMIT="24e88b31709131141ebcb78ee144ccf59f56ef0a"

DESCRIPTION="Simple application for generating Two-Factor Authentication Codes."
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="https://gitlab.gnome.org/World/Authenticator/-/archive/${COMMIT}/Authenticator-${COMMIT}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64 ~amd64"
IUSE="+introspection +vala +wayland"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="network-sandbox"

DEPEND="
	gnome-base/gnome-common
	gui-libs/gtk
	x11-libs/gdk-pixbuf
	x11-libs/libadwaita
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

S="${WORKDIR}/Authenticator-${COMMIT}"

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
