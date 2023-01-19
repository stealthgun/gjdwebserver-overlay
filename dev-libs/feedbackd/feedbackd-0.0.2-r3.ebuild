# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

GMO_COMMIT="1039e7808195d4de367ce2718481641ca8af2427"

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
SRC_URI="
	https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz
	https://gitlab.gnome.org/guidog/gmobile/-/archive/${GMO_COMMIT}/gmobile-${GMO_COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	gnome-base/dconf
	media-libs/gsound
	dev-libs/json-glib
	dev-libs/libgudev:=
"
RDEPEND="${DEPEND}
	dev-libs/feedbackd-device-themes
"
BDEPEND="
	dev-libs/gobject-introspection
	vala? ( $(vala_depend) )
"

src_prepare() {
	default

	use vala && vala_setup
	sed -i 's/-G feedbackd/-G video/g' debian/feedbackd.udev || die
	
	rm -r "${S}"/subprojects/gmobile || die
	mv "${WORKDIR}"/gmobile-"${GMO_COMMIT}" "${S}"/subprojects/gmobile || die
}

src_install() {
	meson_src_install
	udev_newrules "${S}/debian/feedbackd.udev" 90-feedbackd.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
