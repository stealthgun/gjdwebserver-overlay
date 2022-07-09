# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

MY_COMMIT="74b178a363f1e0e4b84309f2a1b1c1c41bf97248"
MY_THEME_COMMIT="68e029639e11a98c26949ffe87bcd6a025de1c55"

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"

SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_COMMIT}/${MY_COMMIT}.tar.gz -> ${P}-${MY_COMMIT}.tar.gz
https://source.puri.sm/Librem5/feedbackd-device-themes/-/archive/${MY_THEME_COMMIT}/feedbackd-device-themes-${MY_THEME_COMMIT}.tar.gz
"

S=${WORKDIR}/${PN}-${MY_COMMIT}

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
		gnome-base/dconf
		media-libs/gsound
		dev-libs/json-glib
		dev-libs/libgudev
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-libs/gobject-introspection
		dev-util/meson
		virtual/pkgconfig
		vala? ( $(vala_depend) )
"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
	sed -i 's/-G feedbackd/-G video/g' "${S}/debian/feedbackd.udev"
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins "${WORKDIR}/feedbackd-device-themes-${MY_THEME_COMMIT}/data/"*.json
	udev_newrules "${S}/debian/feedbackd.udev" 90-feedbackd.rules
}
