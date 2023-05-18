# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit meson gnome2-utils xdg
LIBGD_COMMIT="c7c7ff4e05d3fe82854219091cf116cce6b19de0"
LIBCM_COMMIT="ec50358d3bf102e7f8f1843e537bcf1f150d2b7a"

DESCRIPTION="XMPP and SMS messaging via libpurple and Modemmanager"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="
	https://gitlab.gnome.org/GNOME/libgd/-/archive/${LIBGD_COMMIT}/libgd-${LIBGD_COMMIT}.tar.gz
	https://source.puri.sm/Librem5/libcmatrix/-/archive/${LIBCM_COMMIT}/libcmatrix-${LIBCM_COMMIT}.tar.gz
	https://source.puri.sm/Librem5/chatty/-/archive/v${PV}/${PN}-v${PV}.tar.gz
	"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~arm64"

DEPEND="	gnome-extra/evolution-data-server[phonenumber]
		dev-libs/feedbackd
		gui-libs/libhandy
		x11-plugins/purple-mm-sms
		dev-libs/olm
		dev-libs/libphonenumber
		x11-libs/gtk+:3
		net-im/jabber-base
		x11-plugins/lurch
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	default
	eapply_user
	rm -r "${S}"/subprojects/libgd || die
	mv "${WORKDIR}"/libgd-"${LIBGD_COMMIT}" "${S}"/subprojects/libgd || die
	rm -r "${S}"/subprojects/libcmatrix || die
	mv "${WORKDIR}"/libcmatrix-"${LIBCM_COMMIT}" "${S}"/subprojects/libcmatrix || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
