# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

COMMIT="77963b4714065939a86b329fe611d57d182a573e"
DESCRIPTION="Generate Two-Factor Codes"
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="https://gitlab.gnome.org/World/${PN}/-/archive/${PV}/${PN}-${PV}.tar.gz"

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/Authenticator-${PV}-${COMMIT}"

RDEPEND="

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
