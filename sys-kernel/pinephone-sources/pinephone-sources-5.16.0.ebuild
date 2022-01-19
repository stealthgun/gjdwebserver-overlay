# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and with megi's patch for the PinePhone (Non pro), For the PinePhone Pro please use the pinephone-pro-sources"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

PATCHES=(
	${DISTDIR}/all-${PV}.patch
	
	${FILESDIR}/media-ov5640-Implement-autofocus.patch
    	${FILESDIR}/panic-led.patch

        # Pinephone Keyboard
        ${FILESDIR}/d1d849cae12db71aa81ceedaedc1b17a34790367.patch
        ${FILESDIR}/2423aac2d6f5db55da99e11fd799ee66fe6f54c6.patch
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
	einfo "if you want to cross compile pinephone kernel on amd64 host, follow the https://wiki.gentoo.org/wiki/Cross_build_environment"
	einfo "to setup cross toolchain environment, then create a xmake wrapper like the following, and replace make with xmake in above commands"
	einfo "#!/bin/sh"
	einfo "exec make ARCH='arm64' CROSS_COMPILE='aarch64-unknown-linux-gnu-' INSTALL_MOD_PATH='${SYSROOT}' '$@'"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
