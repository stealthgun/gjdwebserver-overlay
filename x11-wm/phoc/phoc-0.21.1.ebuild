# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson xdg gnome2-utils

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

WL_COMMIT="1f8bb9e0e3058fc31a14866dc52e8f83c1287a09"

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/phoc"

SRC_URI="
	https://gitlab.gnome.org/World/Phosh/phoc/-/archive/${MY_PV}/${MY_P}.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+introspection +systemd test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/wayland-protocols
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/gnome-settings-daemon
	>=gnome-base/gnome-desktop-3.26
	dev-util/vulkan-headers
	sys-apps/systemd
	x11-libs/libdrm
	x11-libs/pixman
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-renderutil
	x11-wm/mutter
	sys-auth/seatd
	x11-apps/xkbcomp
	x11-libs/libxkbcommon
	=gui-libs/wlroots-0.15.1-r2
"

BDEPEND="
	dev-util/ctags
	dev-util/meson
	virtual/pkgconfig
	x11-base/xorg-server
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	rm -r "${S}"/subprojects/wlroots || die "Failed to remove bundled wlroots"
}

src_configure() {
	local emesonargs=(
		-Dtests=false
		-Dembed-wlroots=disabled
	)
	
	meson_src_configure
}

src_install() {
	DESTDIR="${D}" meson_src_install
	dobin "${S}"/helpers/scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
}
