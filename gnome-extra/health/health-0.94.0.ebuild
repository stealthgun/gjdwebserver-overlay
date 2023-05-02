# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

COMMIT="d664384370bb55f0e46a78da094c567a5a7e97c6"
DESCRIPTION="Track your fitness goals"
HOMEPAGE="https://gitlab.gnome.org/World/Health/"
SRC_URI="https://gitlab.gnome.org/World/${PN}/-/archive/0.94.0/${PN}-${PV}.tar.gz"

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/Health-${PV}-${COMMIT}"

RDEPEND="
	dev-libs/glib
	dev-util/blueprint-compiler
	dev-libs/appstream
"

DEPEND="${RDEPEND}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
