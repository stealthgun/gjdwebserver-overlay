# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="ninja"
VALA_MIN_API_VERSION="0.34"
inherit cmake gnome2-utils vala xdg-utils

COMMIT="093491d132bdfbc89794067fbbddfa3ff30c7c0f"

DESCRIPTION="Modern Jabber/XMPP Client using GTK+/Vala with gui-libs/libhandy for mobile device use"
HOMEPAGE="https://dino.im"
LICENSE="GPL-3"
SLOT="0"
IUSE="+gpg +http +omemo +notification-sound"

MY_REPO_URI="https://github.com/dino/dino"
KEYWORDS="amd64 arm64"
SRC_URI="${MY_REPO_URI}/archive/${COMMIT}.tar.gz -> ${PN}-${PV}"


RDEPEND="
	app-text/gspell[vala]
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/icu
	dev-libs/libgee:0.8
	net-libs/glib-networking
	net-libs/libsignal-protocol-c
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
	gui-libs/libhandy
	gpg? ( app-crypt/gpgme:1 )
	http? ( net-libs/libsoup:2.4 )
	omemo? (
		dev-libs/libgcrypt:0
		media-gfx/qrencode
	)
	notification-sound? ( media-libs/libcanberra:0[sound] )
"
DEPEND="
	$(vala_depend)
	${RDEPEND}
	sys-devel/gettext
"

src_prepare() {
	cmake_src_prepare
	vala_src_prepare
}

src_configure() {
	local disabled_plugins=(
		$(usex gpg "" "openpgp")
		$(usex omemo "" "omemo")
		$(usex http  "" "http-files")
	)
	local enabled_plugins=(
		$(usex notification-sound "notification-sound" "")
	)
	local mycmakeargs+=(
		"-DENABLED_PLUGINS=$(local IFS=";"; echo "${enabled_plugins[*]}")"
		"-DDISABLED_PLUGINS=$(local IFS=";"; echo "${disabled_plugins[*]}")"
		"-DVALA_EXECUTABLE=${VALAC}"
	)

	if has test ${FEATURES}; then
		mycmakeargs+=("-DBUILD_TESTS=yes")
	fi

	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}"/xmpp-vala-test || die
}

update_caches() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
