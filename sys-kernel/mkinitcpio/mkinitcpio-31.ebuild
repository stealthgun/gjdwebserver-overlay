# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Arch Linux initramfs generation tools"
HOMEPAGE="https://github.com/archlinux/mkinitcpio"
SRC_URI="https://github.com/archlinux/mkinitcpio/releases/download/v${PV}/mkinitcpio-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

src_compile() {
	local myemakeargs=(
		AR="${AR}"
		CC="${CC}"
		HOSTCC="${BUILD_CC}"
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)'
		HOSTLDFLAGS="${LDFLAGS}"
	)
	
	emake "${myemakeargs[@]}"
}

src_install() {
	emake "install"
}
