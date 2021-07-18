# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala meson gnome2-utils git-r3 xdg

DESCRIPTION="Simple application for generating Two-Factor Authentication Codes."
HOMEPAGE="https://gitlab.gnome.org/World/Authenticator"
SRC_URI="hhttps://gitlab.gnome.org/World/Authenticator/-/archive/v${PV}/${PN}-${PV}.tar.gz"
EGIT_REPO_URI="https://gitlab.gnome.org/World/Authenticator.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""
REQUIRED_USE=""

DEPEND="
	gnome-base/gnome-common
	x11-libs/gtk+:3
	x11-libs/libadwaita
	"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/$PN-${PV}"

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
