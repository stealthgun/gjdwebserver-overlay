# Copyright 2011-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chromium-2 desktop pax-utils unpacker xdg

DESCRIPTION="The web browser from Google"
HOMEPAGE="https://www.google.com/chrome"

KEYWORDS="~arm64"

MY_P="chromium-browser_${PV}-0"

SRC_URI="http://ports.ubuntu.com/pool/universe/c/chromium-browser/${MY_P}ubuntu0.18.04.1_arm64.deb"

SLOT="0"
IUSE="selinux proprietary-codecs"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-fonts/liberation-fonts
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[X]
	x11-libs/libdrm
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-misc/xdg-utils

	proprietary-codecs? (
		=media-video/ffmpeg-extra-chromium-bin-debian-${PV}
		!media-video/ffmpeg-chromium-bin-debian
	)

	!proprietary-codecs? (
		=media-video/ffmpeg-chromium-bin-debian-${PV}
		!media-video/ffmpeg-extra-chromium-bin-debian
	)

"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/chromium-browser.*\\.desktop"
S=${WORKDIR}

pkg_nofetch() {
	eerror "Please wait 24 hours and sync your tree before reporting a bug for chromium fetch failures."
}

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use arm64 || die "This version of Chromium only works on arm64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	pushd "usr/lib/chromium-browser/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

}