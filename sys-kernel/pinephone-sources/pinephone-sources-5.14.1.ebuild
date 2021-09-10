# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
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

	${FILESDIR}/PATCH-v3-01-14-include-linux-memcontrol.h-do-not-warn-in-page_memcg_rcu-if-CONFIG_MEMCG.patch
	${FILESDIR}/PATCH-v3-02-14-include-linux-nodemask.h-define-next_memory_node-if-CONFIG_NUMA.patch
	${FILESDIR}/PATCH-v3-03-14-include-linux-cgroup.h-export-cgroup_mutex.patch
	${FILESDIR}/PATCH-v3-04-14-mm-x86-support-the-access-bit-on-non-leaf-PMD-entries.patch
	${FILESDIR}/PATCH-v3-05-14-mm-vmscan.c-refactor-shrink_node.patch
	${FILESDIR}/PATCH-v3-06-14-mm-workingset.c-refactor-pack_shadow-and-unpack_shadow.patch 
	${FILESDIR}/PATCH-v3-07-14-mm-multigenerational-lru-groundwork.patch
	${FILESDIR}/PATCH-v3-08-14-mm-multigenerational-lru-activation.patch
	${FILESDIR}/PATCH-v3-09-14-mm-multigenerational-lru-mm_struct-list.patch
	${FILESDIR}/PATCH-v3-10-14-mm-multigenerational-lru-aging.patch
	${FILESDIR}/PATCH-v3-11-14-mm-multigenerational-lru-eviction.patch
	${FILESDIR}/PATCH-v3-12-14-mm-multigenerational-lru-user-interface.patch
	${FILESDIR}/PATCH-v3-13-14-mm-multigenerational-lru-Kconfig.patch
	${FILESDIR}/PATCH-v3-14-14-mm-multigenerational-lru-documentation.patch
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
