# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

COMMIT="afeb7faf8a24282434b6381cd78c0f9032972f2c"
DESCRIPTION="A camera library for GTK3"
HOMEPAGE="https://gitlab.gnome.org/jwestman/libaperture"
SRC_URI="https://gitlab.gnome.org/jwestman/libaperture/-/archive/${COMMIT}/libaperture-${COMMIT}.tar.gz -> ${P}.tar.gz "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=media-libs/gstreamer-1.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/libaperture-${COMMIT}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare

}
