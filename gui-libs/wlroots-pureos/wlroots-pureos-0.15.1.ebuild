# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Pluggable, composable, unopinionated modules for building a Wayland compositor"
HOMEPAGE="https://gitlab.freedesktop.org/wlroots/wlroots"

COMMIT="cb07c8c11a2a1db243c47a7b4ee4f47e46a21c8f"
SRC_URI="https://source.puri.sm/Librem5/wlroots/-/archive/${COMMIT}/wlroots-${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
SLOT="0"

S=${WORKDIR}/wlroots-${COMMIT}

LICENSE="MIT"
IUSE="+hwdata +seatd tinywl +udev vulkan x11-backend X"

DEPEND="
	>=dev-libs/libinput-1.14.0:0=
	>=dev-libs/wayland-1.21.0
	>=dev-libs/wayland-protocols-1.28
	media-libs/mesa[egl(+),gles2]
	hwdata? ( sys-apps/hwdata:= )
	seatd? ( sys-auth/seatd:= )
	udev? ( virtual/libudev )
	vulkan? (
		dev-util/glslang:0=
		dev-util/vulkan-headers:0=
		media-libs/vulkan-loader:0=
	)
	>=x11-libs/libdrm-2.4.114:0=
	x11-libs/libxkbcommon
	>=x11-libs/pixman-0.42.0:0=
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
