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
	${FILESDIR}/0103-ccu-sun50i-a64-reparent-clocks-to-lower-speed-oscillator.patch
	${FILESDIR}/0104-quirk-kernel-org-bug-210681-firmware_rome_error.patch
	${FILESDIR}/0105-leds-gpio-make-max_brightness-configurable.patch
    	${FILESDIR}/0106-panic-led.patch

	# keyboard
	${FILESDIR}/pp-keyboard.patch

	# LRU
	${FILESDIR}/Multi-Gen-LRU-Framework.patch
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
