# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson gnome2-utils xdg

COMMIT="a13ec47d07bc9f1e714dffbc9ccf951a4c4b1aa9"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/jwestman/camera"
SRC_URI="https://gitlab.gnome.org/jwestman/camera/-/archive/${COMMIT}/camera-${COMMIT}.tar.gz -> ${P}.tar.gz "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.2.0
	media-libs/aperture
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/gentoo-linux-patch.patch
)

S="${WORKDIR}/camera-${COMMIT}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare

}

src_configure() {
	local emesonargs=(	
	-DCAMERA_BUILD_COMMIT=${COMMIT}
	)

	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
}
