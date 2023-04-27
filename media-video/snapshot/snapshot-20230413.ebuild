# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

COMMIT="682b0b983a56c2776318484b9e4e1835fe05ebce"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="hhttps://gitlab.gnome.org/Incubator/snapshot"
SRC_URI="https://gitlab.gnome.org/Incubator/snapshot/-/archive/${COMMIT}/snapshot-${COMMIT}.tar.gz -> ${P}.tar.gz "

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.2.0
	>=media-libs/gstreamer-1.20.0
"
RDEPEND="${DEPEND}"
BDEPEND=""


S="${WORKDIR}/snapshot-${COMMIT}"


pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
