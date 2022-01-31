# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg

COMMIT="da26b33a98137e542efd840eadae426b0cdb7b42"

DESCRIPTION="XMPP and SMS messaging via libpurple and Modemmanager"
HOMEPAGE="https://source.puri.sm/Librem5/chatty"
SRC_URI="https://source.puri.sm/Librem5/chatty/-/archive/v${PV}/${PN}-v${PV}.tar.gz"


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
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
