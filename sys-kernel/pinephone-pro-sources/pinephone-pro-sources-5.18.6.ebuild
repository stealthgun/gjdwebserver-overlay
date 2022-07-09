# Copyright 1999-2021 Gentoo Authors
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

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and patches for the PinePhone Pro"

MEGI_TAG="orange-pi-5.18-20220615-1100"
SRC_URI="https://github.com/megous/linux/archive/${MEGI_TAG}.tar.gz ${GENPATCHES_URI}"

PATCHES=(
	${FILESDIR}/patch-5.18.4-5
	${FILESDIR}/patch-5.18.5-6
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
