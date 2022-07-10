# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

PKGREL="4"
FIRMWAREVERSION="2.7.0"
CRUSTVERSION="0.5"
COMMMIT="0cc846dafcf6f6270c6587d6fe79011834d6e49a"
MY_P="u-boot-${COMMMIT}"
DESCRIPTION="Das U-boot and utilities for working with Das U-Boot for the PinePhone Pro"
HOMEPAGE="https://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="
	https://source.denx.de/u-boot/u-boot/-/archive/${COMMMIT}/u-boot-${COMMMIT}.tar.gz -> u-boot-${PV}.tar.gz
	https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/snapshot/trusted-firmware-a-${FIRMWAREVERSION}.tar.gz
	https://github.com/crust-firmware/crust/archive/refs/tags/v${CRUSTVERSION}.tar.gz
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
	        eapply "${FILESDIR}"/1001-pinephone-Add-volume_key-environment-variable.patch
	        eapply "${FILESDIR}"/1002-Enable-led-on-boot-to-notify-user-of-boot-status.patch
	        eapply "${FILESDIR}"/1003-mmc-sunxi-Add-support-for-DMA-transfers.patch
	        eapply "${FILESDIR}"/1004-mmc-sunxi-DDR-DMA-support-for-SPL.patch
	        eapply "${FILESDIR}"/1005-spl-ARM-Enable-CPU-caches.patch
	        eapply "${FILESDIR}"/1006-common-expose-DRAM-clock-speed.patch
	        eapply "${FILESDIR}"/1007-Improve-Allwinner-A64-timer-workaround.patch

		}


src_configure() {
	tc-export AR BUILD_CC CC PKG_CONFIG
}

src_compile() {
	cd ${WORKDIR}/crust-${CRUSTVERSION}
	make CROSS_COMPILE=or1k-elf- pinephone_defconfig
	make CROSS_COMPILE=or1k-elf- build/scp/scp.bin
	cp build/scp/scp.bin ${S}
	
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
	
	echo 'CONFIG_IDENT_STRING=" Gentoo Linux"' >> .config
	echo 'CONFIG_BOOTDELAY=" 0"' >> .config
	echo 'CONFIG_SPL_DM_SEQ_ALIAS=" y"' >> .config
	echo 'CONFIG_SF_DEFAULT_BUS=" 1"' >> .config
	echo 'CONFIG_SPL_MMC_SDHCI_SDMA=" n"' >> .config
	echo 'CONFIG_SERIAL_PRESENT=" y"' >> .config
	echo 'CONFIG_GZIP=" y"' >> .config
	echo 'CONFIG_CMD_UNZIP=" y"' >> .config
	echo 'CONFIG_CMD_EXT4=" y"' >> .config
	echo 'CONFIG_SUPPORT_RAW_INITRD=" y"' >> .config
	echo 'CONFIG_CMD_EXT4_WRITE" n"' >> .config
	echo 'CONFIG_EXT4_WRITE" n"' >> .config
	echo 'CONFIG_OF_LIBFDT_OVERLAY=" y"' >> .config

	
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