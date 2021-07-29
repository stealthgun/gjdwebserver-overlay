# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome.org meson multilib-minimal xdg

DESCRIPTION="Flatpak portal library"
HOMEPAGE="https://github.com/flatpak/libportal"
SRC_URI="https://github.com/flatpak/libportal/archive/${PV}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"
IUSE="gtk-doc"

RDEPEND="
	>=dev-libs/glib-2.38.0:2[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/glib-utils
	gtk-doc? (
		>=dev-util/gtk-doc-1.25
		app-text/docbook-xml-dtd:4.3 )
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	>=sys-devel/gettext-0.19.8
"

multilib_src_configure() {
	local emesonargs=(
		$(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_install() {
	meson_src_install
}
