# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="3"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and with Mobian patches for the PinePhone"

MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	#Megi patch set
	${DISTDIR}/all-${PV}.patch
        # Drop Megi's Modem-Power
        "${FILESDIR}"/dts-pinephone-drop-modem-power-node.patch
        # Implement Martijn's improvements for the cameras
        "${FILESDIR}"/media-ov5640-Implement-autofocus.patch
        # Reparent clocks to lower speed-occillator
        "${FILESDIR}"/ccu-sun50i-a64-reparent-clocks-to-lower-speed-oscillator.patch
        # Quirk for Kernel-Bug 210681         
        "${FILESDIR}"/0107-quirk-kernel-org-bug-210681-firmware_rome_error.patch
        # LED patches
        "${FILESDIR}"/0177-leds-gpio-make-max_brightness-configurable.patch
        "${FILESDIR}"/panic-led.patch
)

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
	einfo "# make INSTALL_MOD_PATH=/usr modules_install"
	einfo "# make INSTALL_DTBS_PATH=/boot/dtbs dtbs_install"
	einfo "You will need to create and initramfs afterwards."
	einfo "If you use dracut you can run:"
	einfo "# dracut -m \"rootfs-block base\" --host-only --kver 5.16.2-pinehone-gentoo-arm64"
	einfo "Change 5.16.2-pinehone-gentoo-arm64 to your kernel version installed in /lib/modules"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

