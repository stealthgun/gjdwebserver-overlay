# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor with updates from pureos (for phoc)"
HOMEPAGE="https://source.puri.sm/Librem5/wlroots"

SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
SLOT="0/$(ver_cut 2)"

KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
SLOT="0/$(ver_cut 2)"

LICENSE="MIT"
IUSE="tinywl vulkan x11-backend X +phoc"

DEPEND="
	>=dev-libs/libinput-1.14.0:0=
	>=dev-libs/wayland-1.20.0
	>=dev-libs/wayland-protocols-1.24
	media-libs/mesa[egl(+),gles2,gbm(+)]
	sys-auth/seatd:=
	virtual/libudev
	vulkan? (
		dev-util/glslang:0=
		dev-util/vulkan-headers:0=
		media-libs/vulkan-loader:0=
	)
	>=x11-libs/libdrm-2.4.109:0=
	x11-libs/libxkbcommon
	x11-libs/pixman
	x11-backend? ( x11-libs/libxcb:0= )
	X? (
		x11-base/xwayland
		x11-libs/libxcb:0=
		x11-libs/xcb-util-image
		x11-libs/xcb-util-wm
	)
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-libs/wayland-protocols-1.24
	>=dev-util/meson-0.60.0
	dev-util/wayland-scanner
	virtual/pkgconfig
"

PATCHES=( 
	"${FILESDIR}"/wlroots-0.15.1-tinywl-dont-crash-upon-missing-keyboard.patch 
	"${FILESDIR}"/13fcdba75cf5f21cfd49c1a05f4fa62f77619b40.patch
	"${FILESDIR}"/17b2b06633729f1826715c1d0b84614aa3cedb3a.patch
	"${FILESDIR}"/dd03d839ab56c3e5d7c607a8d76e58e0b75edb85.patch
	
)

	"${FILESDIR}"/8dec751a6d84335fb04288b8efab6dd5c90288d3.patch

src_configure() {
	# xcb-util-errors is not on Gentoo Repository (and upstream seems inactive?)
	local emesonargs=(
		"-Dxcb-errors=disabled"
		$(meson_use tinywl examples)
		-Drenderers=$(usex vulkan 'gles2,vulkan' gles2)
		-Dxwayland=$(usex X enabled disabled)
		-Dbackends=drm,libinput$(usex x11-backend ',x11' '')
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use tinywl; then
		dobin "${BUILD_DIR}"/tinywl/tinywl
	fi
}

pkg_postinst() {
	elog "You must be in the input group to allow your compositor"
	elog "to access input devices via libinput."
}
