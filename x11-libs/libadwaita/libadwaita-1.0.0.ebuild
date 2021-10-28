# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

COMMIT="40c19ab2591763a482ebc79c82f1da32eea3bab6"

DESCRIPTION="Building blocks for modern GNOME applications."
HOMEPAGE="https://gitlab.gnome.org/GNOME/libadwaita"
SRC_URI="https://gitlab.gnome.org/GNOME/libadwaita/-/archive/${COMMIT}/libadwaita-${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	dev-lang/sassc
	gnome-base/gnome-common
	gui-libs/gtk
	dev-libs/fribidi
"

RDEPEND="${DEPEND}"
BDEPEND="
		vala? ( $(vala_depend) )
		dev-util/meson
		dev-libs/gobject-introspection
"

S="${WORKDIR}/$PN-${COMMIT}"

src_install() {
	meson_src_install
}
