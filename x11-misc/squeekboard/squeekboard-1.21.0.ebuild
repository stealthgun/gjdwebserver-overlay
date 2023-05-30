# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8

inherit gnome2-utils meson toolchain-funcs xdg

DESCRIPTION="Virtual keyboard supporting Wayland, built primarily for the Librem 5 phone"
HOMEPAGE="https://gitlab.gnome.org/World/Phosh/squeekboard"
SRC_URI="https://gitlab.gnome.org/World/Phosh/squeekboard/-/archive/v${PV}/squeekboard-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm ~arm64"

RESTRICT="network-sandbox"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/feedbackd
	dev-libs/wayland
	dev-libs/wayland-protocols
	gnome-base/gnome-desktop
	media-fonts/noto-emoji
	x11-libs/gtk+:3[wayland]
"

BDEPEND="
	dev-util/gtk-doc
	dev-util/intltool
	virtual/pkgconfig
	virtual/rust
"

S="${WORKDIR}/${PN}-v${PV}"

QA_FLAGS_IGNORED="/usr/bin/squeekboard-test-layout"

src_prepare() {
	default
	eapply "${FILESDIR}"/0001-Removing-online-deps-since-they-keep-breaking.patch
}

src_install() {
	CC="$(tc-getCC)"
	meson_src_install
	insinto /usr/bin
	doins "${S}/tools/squeekboard-restyled"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
