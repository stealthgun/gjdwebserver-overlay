# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg
PYTHON_COMPAT=( python3_{6,7,8} )

DESCRIPTION="Application for exposing extra settings easily on mobile platforms"
HOMEPAGE="https://gitlab.com/postmarketOS/postmarketos-tweaks/"
SRC_URI="https://gitlab.com/postmarketOS/postmarketos-tweaks/-/archive/${PV}/postmarketos-tweaks-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"
BDEPEND="
"

S="${WORKDIR}/${PN}-${PV}"

src_install() {
	meson_src_install
	insinto /usr/bin
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
