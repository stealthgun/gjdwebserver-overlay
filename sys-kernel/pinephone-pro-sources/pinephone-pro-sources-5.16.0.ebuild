# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2


EAPI="8"
UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="1"
K_BASE_VER="5.16"
K_EXP_GENPATCHES_NOUSE="1"
K_FROM_GIT="yes"
ETYPE="sources"

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for Pinephone Pro"

MEGI_PATCH_COMMIT="382509700d5a3ea447b44f002e9d928fd0a14ad5"
MEGI_PATCH_URI="orange-pi-5.16-20220110-0757"
SRC_URI="https://github.com/megous/linux/archive/${MEGI_PATCH_URI}.tar.gz -> ${P}.tar.gz"

PATCHES=(
	${FILESDIR}/0001-bootsplash.patch
	${FILESDIR}/0001-revert-garbage-collect-fbdev-scrolling-acceleration.patch
	${FILESDIR}/0002-bootsplash.patch
	${FILESDIR}/0002-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
	${FILESDIR}/0003-bootsplash.patch
	${FILESDIR}/0003-revert-fbcon-remove-no-op-fbcon_set_origin.patch
	${FILESDIR}/0004-bootsplash.patch
	${FILESDIR}/0004-revert-fbcon-remove-soft-scrollback-code.patch
	${FILESDIR}/0005-bootsplash.patch
	${FILESDIR}/0006-bootsplash.patch
	${FILESDIR}/0007-bootsplash.patch
	${FILESDIR}/0008-bootsplash.patch
	${FILESDIR}/0009-bootsplash.patch
	${FILESDIR}/0010-bootsplash.patch
	${FILESDIR}/0011-bootsplash.patch
	${FILESDIR}/0012-bootsplash.patch
	${FILESDIR}/ppp-keyboard.patch
	${FILESDIR}/2423aac2d6f5db55da99e11fd799ee66fe6f54c6.patch
	${FILESDIR}/d1d849cae12db71aa81ceedaedc1b17a34790367.patch
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
