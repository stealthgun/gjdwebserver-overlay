# Copyright 2011-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

KEYWORDS="~arm64"

SRC_URI="http://ftp.de.debian.org/debian/pool/main/w/wlroots/libwlroots10_0.15.1-3_arm64.deb"

SLOT="0"
IUSE="selinux"
RESTRICT="bindist mirror strip"

RDEPEND=""
S=${WORKDIR}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker
}
