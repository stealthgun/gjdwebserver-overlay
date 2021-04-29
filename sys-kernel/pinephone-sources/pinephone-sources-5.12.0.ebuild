# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
UNIPATCH_STRICTORDER="yes"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="1"
K_BASE_VER="5.12"
K_EXP_GENPATCHES_NOUSE="1"
K_FROM_GIT="yes"
ETYPE="sources"
CKV="${PVR/-r/-git}"

# only use this if it's not an _rc/_pre release
[ "${PV/_pre}" == "${PV}" ] && [ "${PV/_rc}" == "${PV}" ] && OKV="${PV}"
inherit kernel-2
detect_version


DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for pinephone"
HOMEPAGE="https://www.kernel.org"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
    	${DISTDIR}/all-${PV}.patch
    	${FILESDIR}/enable-hdmi-output-pinetab.patch
    	${FILESDIR}/enable-jack-detection-pinetab.patch
    	${FILESDIR}/pinetab-bluetooth.patch
    	${FILESDIR}/pinetab-accelerometer.patch
	${FILESDIR}/dts-headphone-jack-detection.patch
	${FILESDIR}/0011-dts-pinetab-hardcode-mmc-numbers.patch
	${FILESDIR}/0012-pinephone-fix-pogopin-i2c.patch
	${FILESDIR}/0107-quirk-kernel-org-bug-210681-firmware_rome_error.patch
	${FILESDIR}/0177-leds-gpio-make-max_brightness-configurable.patch
	${FILESDIR}/0178-sun8i-codec-fix-headphone-jack-pin-name.patch
	${FILESDIR}/0179-arm64-dts-allwinner-pinephone-improve-device-tree-5.12.patch
	${FILESDIR}/panic-led-5.12.patch
	${FILESDIR}/PATCH-1-4-HID-magicmouse-add-Apple-Magic-Mouse-2-support.patch
	${FILESDIR}/PATCH-2-4-HID-magicmouse-fix-3-button-emulation-of-Mouse-2.patch
	${FILESDIR}/PATCH-3-4-HID-magicmouse-fix-reconnection-of-Magic-Mouse-2.patch
	${FILESDIR}/PATCH-v2-01-16-include-linux-memcontrol.h-do-not-warn-in-page_memcg_rcu-if-CONFIG_MEMCG.patch
	${FILESDIR}/PATCH-v2-02-16-include-linux-nodemask.h-define-next_memory_node-if-CONFIG_NUMA.patch
	${FILESDIR}/PATCH-v2-03-16-include-linux-huge_mm.h-define-is_huge_zero_pmd-if-CONFIG_TRANSPARENT_HUGEPAGE.patch
	${FILESDIR}/PATCH-v2-04-16-include-linux-cgroup.h-export-cgroup_mutex.patch
	${FILESDIR}/PATCH-v2-05-16-mm-swap.c-export-activate_page.patch
	${FILESDIR}/PATCH-v2-06-16-mm-x86-support-the-access-bit-on-non-leaf-PMD-entries.patch
	${FILESDIR}/PATCH-v2-07-16-mm-vmscan.c-refactor-shrink_node.patch
	${FILESDIR}/PATCH-v2-08-16-mm-multigenerational-lru-groundwork.patch
	${FILESDIR}/PATCH-v2-09-16-mm-multigenerational-lru-activation.patch
	${FILESDIR}/PATCH-v2-10-16-mm-multigenerational-lru-mm_struct-list.patch
	${FILESDIR}/PATCH-v2-11-16-mm-multigenerational-lru-aging.patch
	${FILESDIR}/PATCH-v2-12-16-mm-multigenerational-lru-eviction.patch
	${FILESDIR}/PATCH-v2-13-16-mm-multigenerational-lru-page-reclaim.patch
	${FILESDIR}/PATCH-v2-14-16-mm-multigenerational-lru-user-interface.patch
	${FILESDIR}/PATCH-v2-15-16-mm-multigenerational-lru-Kconfig.patch
	${FILESDIR}/PATCH-v2-16-16-mm-multigenerational-lru-documentation.patch
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
	einfo "make install; make modules_install; make dtbs_install"
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
