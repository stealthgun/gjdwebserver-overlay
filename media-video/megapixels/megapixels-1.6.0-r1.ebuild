# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="A GTK3 camera application that knows how to deal with the media request api"
HOMEPAGE="https://gitlab.com/postmarketOS/megapixels"
SRC_URI="https://gitlab.com/postmarketOS/megapixels/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	gui-libs/gtk
	x11-libs/gtk+:3
	media-libs/tiff
	media-gfx/zbar
	media-libs/libepoxy
	media-libs/libraw
	media-gfx/dcraw
	media-gfx/imagemagick
"

RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/8df7905...444cacf.patch
	"${FILESDIR}"/06230f3a02cffdf8b683f85cb32fc256d73615d9.patch
        "${FILESDIR}"/27a1e606d680295e0b4caceadf74ff5857ac16b2.patch
        "${FILESDIR}"/d8b35bc223989cb165ba1b0716ab9f0ca9c43e53.patch
)	

src_configure() {
	# 6.1 changes selfie cam name
    	# https://github.com/megous/linux/commit/59ee4accb3997098c7b65fbf529ef3033ab1fd5a
	sed -i -e 's/m00_f_ov8858/ov8858/g' 'config/pine64,pinephone-pro.ini'

	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
