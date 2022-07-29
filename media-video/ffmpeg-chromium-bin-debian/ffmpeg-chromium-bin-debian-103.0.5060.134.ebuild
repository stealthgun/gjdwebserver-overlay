# Copyright 2011-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit chromium-2 desktop pax-utils unpacker xdg

KEYWORDS="~arm64"

MY_P="chromium-codecs-ffmpeg_${PV}-0"

SRC_URI="http://ports.ubuntu.com/pool/universe/c/chromium-browser/${MY_P}ubuntu0.18.04.1_arm64.deb"

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
