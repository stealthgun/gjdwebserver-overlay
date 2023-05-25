# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
inherit gnome.org meson python-any-r1 vala virtualx

DESCRIPTION="Building blocks for modern adaptive GNOME applications"
HOMEPAGE="https://gnome.pages.gitlab.gnome.org/libadwaita/ https://gitlab.gnome.org/GNOME/libadwaita"
SRC_URI="https://gitlab.gnome.org/GNOME/libadwaita/-/archive/a97fa1541229271610ce47a4a1dcea4c0340b84c/libadwaita-a97fa1541229271610ce47a4a1dcea4c0340b84c.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="1"
IUSE="+introspection test +vala"
REQUIRED_USE="vala? ( introspection )"

KEYWORDS="~arm ~arm64"

S="${WORKDIR}/libadwaita-a97fa1541229271610ce47a4a1dcea4c0340b84c"

RDEPEND="
	>=dev-libs/glib-2.72:2
	>=gui-libs/gtk-4.11.2:4[introspection?]
	dev-libs/fribidi
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
	dev-lang/sassc
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	vala? ( $(vala_depend) )
	dev-util/glib-utils
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-libs/appstream-glib )
"

src_prepare() {
	default
	use vala && vala_setup
}

src_configure() {
	local emesonargs=(
		# Never use gi-docgen subproject
		--wrap-mode nofallback

		-Dprofiling=false
		$(meson_feature introspection)
		$(meson_use vala vapi)
		-Dgtk_doc=false # we ship pregenerated docs
		$(meson_use test tests)
		-Dexamples=false
	)
	meson_src_configure
}

src_test() {
	virtx meson_src_test --timeout-multiplier 2
}

src_install() {
	meson_src_install

	insinto /usr/share/gtk-doc/html
	# This will install libadwaita API docs unconditionally, but this is intentional
	doins -r "${S}"/doc/libadwaita-1
}
