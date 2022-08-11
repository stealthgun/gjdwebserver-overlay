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

MEGI_TAG="orange-pi-5.19-20220802-0940"
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
	${FILESDIR}/0104-rk818_charger-use-type-battery-again.patch
	${FILESDIR}/0201-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
	${FILESDIR}/0202-revert-fbcon-remove-no-op-fbcon_set_origin.patch
	${FILESDIR}/0203-revert-fbcon-remove-soft-scrollback-code.patch
	
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
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
	einfo "To build the kernel use the following command:"
	einfo "make Image Image.gz modules"
	einfo "make DTC_FLAGS="-@" dtbs"
	einfo "make install; make modules_intall; make dtbs_install"
	einfo "If you use kernel config coming with this ebuild, don't forget to also copy dracut-pp.conf to /etc/dracut.conf.d/"
	einfo "to make sure proper kernel modules are loaded into initramfs"
	einfo "if you want to cross compile pinephone kernel on amd64 host, follow the https://wiki.gentoo.org/wiki/Cross_build_environment"
	einfo "to setup cross toolchain environment, then create a xmake wrapper like the following, and replace make with xmake in above commands"
	einfo "#!/bin/sh"
	einfo "exec make ARCH='arm64' CROSS_COMPILE='aarch64-unknown-linux-gnu-' INSTALL_MOD_PATH='${SYSROOT}' '$@'"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
