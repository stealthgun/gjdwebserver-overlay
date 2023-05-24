# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="Telegram client"
HOMEPAGE="https://github.com/paper-plane-developers/"
SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v0.1.0-beta.1.tar.gz"

#allready added for final release
#SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="CC-BY-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/paper-plane-0.1.0-beta.1"
#S="${WORKDIR}/${PN}-${PV}"

#>=gui-libs/libadwaita-1.4.0
RDEPEND="
	
	>=gui-libs/gtk-4.10.0
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-libav
"

DEPEND="${RDEPEND}"

BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
src_prepare() {
	default
	vala_setup
	
	#-Dtg_api_id=ID 
	#-Dtg_api_hash=HASH
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
