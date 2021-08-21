# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit vala meson gnome2-utils git-r3 xdg
EGIT_REPO_URI="https://source.puri.sm/Librem5/phoc.git"

KEYWORDS="~x86 ~amd64 ~arm ~arm64"
if [[ ${PV} != 9999 ]]; then
    #EGIT_COMMIT="tags/v${PV}"
	EGIT_COMMIT="527689df1300277af2cdfc872474c8322e38f690"
else
    KEYWORDS=""
fi

WLROOT=0.12.0

SRC_URI="https://github.com/swaywm/wlroots/archive/${WLROOT}.tar.gz -> wlroot-${WLROOT}.tar.gz"


PATCHES=(
	"${FILESDIR}/0001-seat-Don-t-notify-on-key-release.patch"
	"${FILESDIR}/0002-seat-inhibit-touch-events-when-in-power-save-mode-or.patch"
	#"${FILESDIR}/xcursor-fix-false-positive-stringop-truncation.diff"
	#"${FILESDIR}/Revert-layer-shell-error-on-0-dimension-without-anchors.diff"
)

DESCRIPTION="Wlroots based Phone compositor"
HOMEPAGE="https://source.puri.sm/Librem5/phoc"

LICENSE="GPL-3"
SLOT="0"
IUSE="+introspection"

	#<=gui-libs/wlroots-0.11.0:0/11
DEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/libinput
	gnome-base/gnome-desktop
	!gui-libs/wlroots
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-wm/mutter
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-util/ctags
		x11-base/xorg-server
		dev-util/meson
		virtual/pkgconfig
"

src_unpack() {
	default
	git-r3_fetch
	git-r3_checkout
	rm -rf ${S}/subprojects/wlroots
	mv ${WORKDIR}/wlroots-${WLROOT} ${S}/subprojects/wlroots
}

src_prepare() {
	default
	eapply_user
	cd subprojects/wlroots
	eapply ${FILESDIR}/xcursor-fix-false-positive-stringop-truncation.diff
	eapply ${FILESDIR}/Revert-layer-shell-error-on-0-dimension-without-anchors.diff
}

src_configure() {
	local emesonargs=(
		-Ddefault_library=shared
		-Dtests=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	dobin ${S}/helpers/scale-to-fit
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
