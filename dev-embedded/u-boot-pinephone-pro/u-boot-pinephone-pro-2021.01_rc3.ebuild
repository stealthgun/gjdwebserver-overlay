# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

PKGREL="4"
FIRMWAREVERSION="2.6"
COMMMIT="0719bf42931033c3109ecc6357e8adb567cb637b"
MY_P="u-boot-${COMMMIT}"
DESCRIPTION="Das U-boot and utilities for working with Das U-Boot for the PinePhone Pro"
HOMEPAGE="https://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="
	https://source.denx.de/u-boot/u-boot/-/archive/${COMMMIT}/u-boot-${COMMMIT}.tar.gz -> u-boot-${PV}.tar.gz
	https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/snapshot/trusted-firmware-a-${FIRMWAREVERSION}.tar.gz
"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm64"
IUSE="envtools"


RDEPEND="dev-libs/openssl:="
DEPEND="${RDEPEND}"
BDEPEND="
	sys-apps/dtc
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i 's:\bpkg-config\b:${PKG_CONFIG}:g' \
		scripts/kconfig/{g,m,n,q}conf-cfg.sh \
		scripts/kconfig/Makefile \
		tools/Makefile || die
		
		#Apply PinePhone Pro patches
		eapply "${FILESDIR}"/0001-PPP.patch
		eapply "${FILESDIR}"/0002-Add-ppp-dt.patch
		eapply "${FILESDIR}"/0003-Config-changes.patch
		eapply "${FILESDIR}"/0004-Add-kconfig-include.patch
		eapply "${FILESDIR}"/0005-Add-pinephone-pro-rk3399.h.patch
		eapply "${FILESDIR}"/0006-Added-dts-to-makefile.patch
		eapply "${FILESDIR}"/0007-u-boot.dtsi-fixes.patch
		eapply "${FILESDIR}"/0008-fix-boot-order.patch
		eapply "${FILESDIR}"/0009-Correct-boot-order-to-be-USB-SD-eMMC.patch
}

src_configure() {
	tc-export AR BUILD_CC CC PKG_CONFIG
}

src_compile() {
	cd ${WORKDIR}/trusted-firmware-a-${FIRMWAREVERSION}
	unset CFLAGS CXXFLAGS CPPFLAGS LDFLAGS
	make PLAT=rk3399
	cp build/rk3399/release/bl31/bl31.elf ${S}
	
	cd ${S}
	
	# Unset a few KBUILD variables. Bug #540476
	unset KBUILD_OUTPUT KBUILD_SRC

	local myemakeargs=(
		AR="${AR}"
		CC="${CC}"
		HOSTCC="${BUILD_CC}"
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)'
		HOSTLDFLAGS="${LDFLAGS}"
	)

	emake "${myemakeargs[@]}" pinephone-pro-rk3399_defconfig
	
	echo 'CONFIG_IDENT_STRING=" Gentoo"' >> .config
	echo 'CONFIG_USB_EHCI_HCD=n' >> .config
	echo 'CONFIG_USB_EHCI_GENERIC=n' >> .config
	echo 'CONFIG_USB_XHCI_HCD=n' >> .config
	echo 'CONFIG_USB_XHCI_DWC3=n' >> .config
	echo 'CONFIG_USB_DWC3=n' >> .config
	echo 'CONFIG_USB_DWC3_GENERIC=n' >> .config


	emake "${myemakeargs[@]}" EXTRAVERSION=-${PKGREL}
	
	emake "${myemakeargs[@]}" \
		NO_SDL=1 \
		HOSTSTRIP=: \
		STRIP=: \
		CONFIG_ENV_OVERWRITE=y \
		$(usex envtools envtools tools-all)	
}

src_test() { :; }

src_install() {
	insinto /boot/
	doins ${S}/u-boot.itb
	
	insinto /boot/
	doins ${S}/idbloader.img
		
	cd tools || die

	if ! use envtools; then
		dobin bmp_logo dumpimage fdtgrep gen_eth_addr img2srec mkenvimage mkimage
	fi

	dobin env/fw_printenv

	dosym fw_printenv /usr/bin/fw_setenv

	insinto /etc
	doins env/fw_env.config

	doman ../doc/mkimage.1
}

pkg_postinst() {
	einfo "This U-Boot is only to be used for the PinePhone Pro."
	einfo "After compiling a new Gentoo kernel, copy the resulting Image from /usr/src/linux/arch/arm64/boot/zImage to the boot partition (replacing the existing Image)."	
}
