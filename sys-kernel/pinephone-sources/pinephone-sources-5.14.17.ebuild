# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~arm64"
# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for pinephone"

MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	${DISTDIR}/all-${PV}.patch
    ${FILESDIR}/enable-hdmi-output-pinetab.patch
    ${FILESDIR}/enable-jack-detection-pinetab.patch
    ${FILESDIR}/pinetab-bluetooth.patch
    ${FILESDIR}/pinetab-accelerometer.patch
	${FILESDIR}/dts-pinephone-drop-modem-power-node.patch
	${FILESDIR}/media-ov5640-Implement-autofocus.patch
	${FILESDIR}/0011-dts-pinetab-hardcode-mmc-numbers.patch
	${FILESDIR}/0107-quirk-kernel-org-bug-210681-firmware_rome_error.patch
	${FILESDIR}/0177-leds-gpio-make-max_brightness-configurable.patch
    ${FILESDIR}/panic-led-5.12.patch
	#${FILESDIR}/0178-sun8i-codec-fix-headphone-jack-pin-name.patch
	#${FILESDIR}/0179-arm64-dts-allwinner-pinephone-improve-device-tree-5.12.patch
    #${FILESDIR}/improve-jack-button-handling-and-mic.patch

	# keyboard
    ${FILESDIR}/d1d849cae12db71aa81ceedaedc1b17a34790367.patch
    ${FILESDIR}/2423aac2d6f5db55da99e11fd799ee66fe6f54c6.patch

	# LRU
	${FILESDIR}/Multigenerational-LRU-Framework.patch
)

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
