# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Mobile and privacy friendly configuration for Firefox"
HOMEPAGE="https://gitlab.com/postmarketOS/mobile-config-firefox"
SRC_URI="https://gitlab.com/postmarketOS/mobile-config-firefox/-/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	default
	mv ${D}/usr/lib ${D}/usr/lib64
}
