# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils git-r3 xdg

DESCRIPTION="Cawbird is a fork of the Corebird Twitter client from Baedert."
HOMEPAGE="https://github.com/IBBoard/cawbird"
SRC_URI="https://github.com/IBBoard/cawbird/archive/refs/tags/v${PV}.tar.gz"
EGIT_REPO_URI="https://github.com/IBBoard/cawbird.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	gui-libs/gtk
"
RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
"

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
