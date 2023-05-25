# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-v2

EAPI=8

inherit gnome2-utils meson

DESCRIPTION="Telegram client"
HOMEPAGE="https://github.com/paper-plane-developers/"
SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v0.1.0-beta.1.tar.gz"

#allready added for final release
#SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="CC-BY-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RESTRICT="network-sandbox"

S="${WORKDIR}/paper-plane-0.1.0-beta.1"
#S="${WORKDIR}/${PN}-${PV}"


DEPEND="
	>=gui-libs/libadwaita-1.4.0_alpha
	>=gui-libs/gtk-4.10.0
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-libav
	>=net-libs/td-1.8.14
	>=dev-util/blueprint-compiler-0.8.0
	media-libs/rlottie
"

RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_prepare() {
	default
	local emesonargs=(
		"-Dtg_api_id=25355557"
		"-Dtg_api_hash=5721a74e34aeb9d45c09a9ff51f14fdf"
	)	
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
