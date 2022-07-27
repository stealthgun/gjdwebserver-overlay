# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI="8"
ETYPE="sources"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="9"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and patches for the PinePhone"

MEGI_TAG="orange-pi-5.18-20220615-1100"
SRC_URI="https://github.com/megous/linux/archive/${MEGI_TAG}.tar.gz ${GENPATCHES_URI}"

PATCHES=(
        # Drop Megi's Modem-Power
	"${FILESDIR}"/0101-arm64-dts-pinephone-drop-modem-power-node.patch
        "${FILESDIR}"/0102-arm64-dts-pinephone-pro-remove-modem-node.patch
        # Reparent clocks to lower speed-occillator
        "${FILESDIR}"/0103-ccu-sun50i-a64-reparent-clocks-to-lower-speed-oscillator.patch
        # Quirk for Kernel-Bug 210681
        "${FILESDIR}"/0104-quirk-kernel-org-bug-210681-firmware_rome_error.patch
        # LED patches
        "${FILESDIR}"/0105-leds-gpio-make-max_brightness-configurable.patch
        "${FILESDIR}"/0106-panic-led.patch
        # Bootsplash
        "${FILESDIR}"/0201-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
        "${FILESDIR}"/0202-revert-fbcon-remove-no-op-fbcon_set_origin.patch
        "${FILESDIR}"/0203-revert-fbcon-remove-soft-scrollback-code.patch
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
	einfo "# dracut -m \"rootfs-block base\" --host-only --kver 5.18.3-pinehone-gentoo-arm64"
	einfo "Change 5.18.2-pinehone-gentoo-arm64 to your kernel version installed in /lib/modules"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

