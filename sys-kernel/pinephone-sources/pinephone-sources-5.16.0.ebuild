# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI="8"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"

MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and with megi's patch for the PinePhone and PinePhone Pro"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	#Megi patch set
	${DISTDIR}/all-${PV}.patch
        # Pinephone Keyboard
        ${FILESDIR}/pp-keyboard.patch
        ${FILESDIR}/ppp-keyboard.patch
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

