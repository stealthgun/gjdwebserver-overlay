# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

COMMIT="847a303b1017479b4d412a7786a618fd2fe4f323"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/GNOME/Incubator/snapshot"
SRC_URI="https://gitlab.gnome.org/GNOME/Incubator/snapshot-/archive/${COMMIT}/snapshot-${COMMIT}.tar.gz -> ${P}.tar.gz "

RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.4.0_alpha
	>=media-libs/gstreamer-1.20.0
	media-video/wireplumber
	media-video/pipewire[gstreamer]
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
