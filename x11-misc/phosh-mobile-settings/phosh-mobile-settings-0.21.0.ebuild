# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8
inherit gnome2-utils meson

DESCRIPTION="A settings app for mobile specific things"
HOMEPAGE="https://gitlab.gnome.org/guidog/phosh-mobile-settings"
SRC_URI="https://gitlab.gnome.org/guidog/phosh-mobile-settings/-/archive/v${PV}/phosh-mobile-settings-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~arm64"

RDEPEND="
	x11-wm/phoc
	gui-wm/phosh
"

BDEPEND="
"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	default
}

src_install() {
	CC="$(tc-getCC)"
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
