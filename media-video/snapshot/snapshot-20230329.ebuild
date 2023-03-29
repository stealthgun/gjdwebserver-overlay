# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
 ashpd-0.4.0
 futures-channel-0.3.26
 futures-util-0.3.26
 gst-plugin-gtk4-0.10.3
 libc-0.2.139
"

VALA_USE_DEPEND="vapigen"

inherit cargo vala meson gnome2-utils toolchain-funcs xdg

COMMIT="7aa6b9f7e48665739f718d615a4ee7cfa6fd282b"
DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/msandova/snapshot"
SRC_URI="https://gitlab.gnome.org/msandova/snapshot/-/archive/${COMMIT}/snapshot-${COMMIT}.tar.gz -> ${P}.tar.gz "
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

RESTRICT="network-sandbox"

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


S="${WORKDIR}/snapshot-${COMMIT}"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare

}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
}
