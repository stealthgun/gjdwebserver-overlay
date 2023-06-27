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
	media-gfx/argyllcms
"

RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/8103e662a484c0887d29f11a1284f85ff34d0248.patch
        "${FILESDIR}"/af01107dd65452db159eb961b7ff27b8424cffc7.patch
        "${FILESDIR}"/432d3851d49e4f8a9ef196eb0887cef428ba56c6.patch
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
