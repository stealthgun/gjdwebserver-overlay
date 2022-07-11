# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

PKGREL="4"
FIRMWAREVERSION="2.7.0"
COMMMIT="0cc846dafcf6f6270c6587d6fe79011834d6e49a"
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
	        eapply "${FILESDIR}"/1001-Correct-boot-order-to-be-USB-SD-eMMC.patch
	        eapply "${FILESDIR}"/1002-rockchip-Add-initial-support-for-the-PinePhone-Pro.patch
	        #eapply "${FILESDIR}"/1003-Configure-USB-power-settings-for-PinePhone-Pro.patch
	        eapply "${FILESDIR}"/1004-mtd-spi-nor-ids-Add-GigaDevice-GD25LQ128E-entry.patch
	        eapply "${FILESDIR}"/1005-Reconfigure-GPIO4_D3-as-input-on-PinePhone-Pro.patch
	        eapply "${FILESDIR}"/2001-mmc-sdhci-allow-disabling-sdma-in-spl.patch
	        eapply "${FILESDIR}"/3001-pinephone-pro-Remove-cargo-culted-iodomain-config.patch
	        eapply "${FILESDIR}"/3002-pine64-pinephonePro-SPI-support.patch
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
	
	echo "CONFIG_IDENT_STRING=' Gentoo Linux'" >> .config
	echo "CONFIG_BOOTDELAY'='0'" >> .config
	echo "CONFIG_SPL_DM_SEQ_ALIAS='y'" >> .config
	echo "CONFIG_SF_DEFAULT_BUS='1'" >> .config
	echo "CONFIG_SPL_MMC_SDHCI_SDMA'='n'" >> .config
	
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
	einfo "After compiling a new Gentoo kernel, copy the resulting Image from /usr/src/linux/arch/arm64/boot/Image to the boot partition (replacing the existing Image)."	
  	einfo "New version of U-Boot firmware can be flashed to your microSD card or eMMc module."
  	einfo "You can do that by running:"
  	einfo "# dd if=/boot/idbloader.img of=/dev/mmcblkX seek=64 conv=notrunc,fsync"
	einfo "# dd if=/boot/u-boot.itb of=/dev/mmcblkX seek=16384 conv=notrunc,fsync"
	einfo "Due to the Boot Priority for the PPP it is HIGHLY recommended to not put U-Boot on the eMMc because there is no easy way to recover is something went wrong."
}
