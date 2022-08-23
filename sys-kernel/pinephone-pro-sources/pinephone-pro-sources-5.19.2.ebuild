# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_GENPATCHES_VER="1"
ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for pinephone and gentoo patchset"

MEGI_TAG="orange-pi-5.19-20220818-0237"
SRC_URI="https://github.com/megous/linux/archive/${MEGI_TAG}.tar.gz"

PATCHES=(
	#Gentoo Patches
	${FILESDIR}/1500_XATTR_USER_PREFIX.patch
	${FILESDIR}/1510_fs-enable-link-security-restrictions-by-default.patch
	${FILESDIR}/1700_sparc-address-warray-bound-warnings.patch
	${FILESDIR}/2000_BT-Check-key-sizes-only-if-Secure-Simple-Pairing-enabled.patch
	${FILESDIR}/2900_tmp513-Fix-build-issue-by-selecting-CONFIG_REG.patch
	${FILESDIR}/2920_sign-file-patch-for-libressl.patch
	${FILESDIR}/3000_Support-printing-firmware-info.patch
	${FILESDIR}/4567_distro-Gentoo-Kconfig.patch
	${FILESDIR}/5010_enable-cpu-optimizations-universal.patch
	${FILESDIR}/5020_BMQ-and-PDS-io-scheduler-v5.19-r0.patch
	${FILESDIR}/5021_BMQ-and-PDS-gentoo-defaults.patch

	#PinePhone Patches
	${FILESDIR}/0101-arm64-dts-pinephone-drop-modem-power-node.patch
	${FILESDIR}/0102-arm64-dts-pinephone-pro-remove-modem-node.patch
	${FILESDIR}/0103-arm64-dts-rk3399-pinephone-pro-add-modem-RI-pin.patch
	${FILESDIR}/0201-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
	${FILESDIR}/0202-revert-fbcon-remove-no-op-fbcon_set_origin.patch
	#${FILESDIR}/0203-revert-fbcon-remove-soft-scrollback-code.patch
		
	#Bootsplash
	${FILESDIR}/0301-bootsplash.patch
	${FILESDIR}/0302-bootsplash.patch
	${FILESDIR}/0303-bootsplash.patch
	${FILESDIR}/0304-bootsplash.patch
	${FILESDIR}/0305-bootsplash.patch
	${FILESDIR}/0306-bootsplash.patch
	${FILESDIR}/0307-bootsplash.patch
	${FILESDIR}/0308-bootsplash.patch
	${FILESDIR}/0309-bootsplash.patch
	${FILESDIR}/0310-bootsplash.patch
	${FILESDIR}/0311-bootsplash.patch
	${FILESDIR}/0312-bootsplash.patch
)

S="${WORKDIR}/linux-${MEGI_TAG}"

src_unpack() {
	default
}

src_prepare() {
	default
	eapply_user
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "To build and install the kernel use the following commands:"
	einfo "# make Image modules"
	einfo "# make DTC_FLAGS="-@" dtbs"
	einfo "# cp arch/arm64/boot/Image /boot"
	einfo "# make INSTALL_MOD_PATH=/ modules_intall"
	einfo "# make INSTALL_DTBS_PATH=/boot/dtbs dtbs_install"
	einfo "You will need to create and initramfs afterwards."
	einfo "If you use dracut you can run:"
	einfo "# dracut -m \"rootfs-block base\" --host-only --kver 5.19.2-pinehone-gentoo-arm64"
	einfo "Change 5.19.2-pinehone-gentoo-arm64 to your kernel version installed in /lib/modules"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
