# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
#GNOME2_LA_PUNT="yes"
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

if [[ ${PV} == "0.0.0" ]]; then
	MY_PV="v${PV}+git20210125"
	MY_P="${PN}-${MY_PV}"
fi

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
if [[ ${PV} == 9999 ]]; then
	inherit vala meson udev git-r3
	EGIT_REPO_URI="https://source.puri.sm/Librem5/feedbackd.git"
	SRC_URI=""
else
	EGIT_REPO_URI=""
	SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_PV}/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
fi
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
		gnome-base/dconf
		media-libs/gsound
		dev-libs/json-glib
		virtual/libudev
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-libs/gobject-introspection
		dev-util/meson
		dev-util/pkgconfig
		vala? ( $(vala_depend) )
"
src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
	sed -i 's/-G feedbackd/-G video/g' ${S}/debian/feedbackd.udev
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins ${FILESDIR}/*.json
	udev_newrules ${S}/debian/feedbackd.udev 90-feedbackd.rules
}
