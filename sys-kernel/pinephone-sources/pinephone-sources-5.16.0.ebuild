# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
ETYPE="sources"
inherit kernel-2
detect_version

KEYWORDS="~arm64"

DEPEND="${RDEPEND}
	>=sys-devel/patch-2.7.5"

DESCRIPTION="Full sources for the Linux kernel, with megi's patch for pinephone"

MEGI_PATCH_URI="https://xff.cz/kernels/${PV:0:4}/patches/all.patch"
SRC_URI="${KERNEL_URI} ${MEGI_PATCH_URI} -> all-${PV}.patch"

PATCHES=(
	${DISTDIR}/all-${PV}.patch
	
	${FILESDIR}/0001-base-property-Swap-order-of-search-for-connection-to.patch
        ${FILESDIR}/0002-sdhci-arasan-Add-runtime-PM-support.patch
        ${FILESDIR}/0003-clk-rk3399-Export-SCLK_CIF_OUT_SRC-to-device-tree.patch
        ${FILESDIR}/0004-media-rockchip-rga-Fix-probe-bugs.patch
        ${FILESDIR}/0005-drm-dw-mipi-dsi-rockchip-Ensure-that-lane-is-properl.patch
        ${FILESDIR}/0006-drm-rockchip-dw-mipi-dsi-Fix-missing-clk_disable_unp.patch
        ${FILESDIR}/0007-drm-bridge-dw-mipi-dsi-Fix-enable-disable-of-dsi-con.patch
        ${FILESDIR}/0008-drm-dw-mipi-dsi-rockchip-Never-allow-lane-bandwidth-.patch
        ${FILESDIR}/0009-drm-rockchip-cdn-dp-Disable-CDN-DP-on-disconnect.patch
        ${FILESDIR}/0010-video-fbdev-Add-events-for-early-fb-event-support.patch
        ${FILESDIR}/0011-power-rk818-Configure-rk808-clkout2-function.patch
        ${FILESDIR}/0012-power-rk818-battery-Add-battery-driver-for-RK818.patch
        ${FILESDIR}/0013-power-supply-rk818-battery-Use-a-more-propper-compat.patch
        ${FILESDIR}/0014-power-supply-core-Don-t-ignore-max_current-of-0-when.patch
        ${FILESDIR}/0015-power-supply-rk818-charger-Implement-charger-driver-.patch
        ${FILESDIR}/0016-usb-typec-fusb302-Set-the-current-before-enabling-pu.patch
        ${FILESDIR}/0017-usb-typec-fusb302-Extend-debugging-interface-with-dr.patch
        ${FILESDIR}/0018-usb-typec-fusb302-Retry-reading-of-CC-pins-status-if.patch
        ${FILESDIR}/0019-usb-typec-fusb302-More-useful-of-logging-status-on-i.patch
        ${FILESDIR}/0020-usb-typec-fusb302-Update-VBUS-state-even-if-VBUS-int.patch
        ${FILESDIR}/0021-usb-typec-fusb302-Make-tcpm-fusb302-logs-less-pollut.patch
        ${FILESDIR}/0022-usb-typec-fusb302-Add-OF-extcon-support.patch
        ${FILESDIR}/0023-usb-typec-fusb302-Fix-register-definitions.patch
        ${FILESDIR}/0024-usb-typec-fusb302-Clear-interrupts-before-we-start-t.patch
        ${FILESDIR}/0025-usb-typec-typec-extcon-Add-typec-extcon-bridge-drive.patch
        ${FILESDIR}/0026-phy-rockchip-typec-Make-sure-the-plug-orientation-is.patch
        ${FILESDIR}/0027-media-i2c-imx258-Add-support-for-powerdown-gpio.patch
        ${FILESDIR}/0028-media-i2c-imx258-Don-t-be-too-strict-about-clock-rat.patch
        ${FILESDIR}/0029-media-i2c-imx258-Add-support-for-reset-gpio.patch
        ${FILESDIR}/0030-media-i2c-imx258-Add-support-for-power-supplies.patch
        ${FILESDIR}/0031-media-ov5640-Add-more-framerates-to-the-driver-some-.patch
        ${FILESDIR}/0032-media-ov5640-Experiment-Try-to-disable-denoising-sha.patch
        ${FILESDIR}/0033-media-ov5640-Sleep-after-poweroff-to-ensure-next-pow.patch
        ${FILESDIR}/0034-media-ov5640-Don-t-powerup-the-sensor-during-driver-.patch
        ${FILESDIR}/0035-media-ov5640-Implement-autofocus.patch
        ${FILESDIR}/0036-media-ov5640-set-default-ae-target-lower.patch
        ${FILESDIR}/0037-drm-panel-hx8394-Add-driver-for-HX8394-based-HannSta.patch
        ${FILESDIR}/0038-drm-panel-hx8394-Improve-the-panel-driver-make-it-wo.patch
        ${FILESDIR}/0039-drm-panel-hx8394-Fix-mode-clock-for-the-pinephone-pr.patch
        ${FILESDIR}/0040-input-goodix-Add-option-to-power-off-the-controller-.patch
        ${FILESDIR}/0041-input-goodix-Don-t-disable-regulators-during-suspend.patch
        ${FILESDIR}/0042-input-touchscreen-goodix-Respect-IRQ-flags-from-DT-w.patch
        ${FILESDIR}/0043-input-touchscreen-goodix-Add-support-for-GT1158.patch
        ${FILESDIR}/0044-arm64-dts-rk3399-pinephone-pro-Add-support-for-Pinep.patch
        ${FILESDIR}/0045-arm64-dts-rk3399-pinephone-pro-Fixup-DT-validation-i.patch
        ${FILESDIR}/0046-arm64-dts-rk3399-pinephone-pro-Make-charging-and-per.patch
        ${FILESDIR}/0047-arm64-dts-rk3399-pinephone-pro-Fix-goodix-toucscreen.patch
        ${FILESDIR}/0048-arm64-dts-rk3399-pinephone-pro-Correct-the-pmu1830-i.patch
        ${FILESDIR}/0049-arm64-dts-rk3399-pinephone-pro-Power-off-goodix-touc.patch
        ${FILESDIR}/0050-arm64-dts-rk3399-pinephone-pro-Add-support-for-both-.patch
        ${FILESDIR}/0051-arm64-dts-rk3399-pinephone-pro-Fix-SD-card-power-sup.patch
        ${FILESDIR}/0052-arm64-dts-rk3399-pinephone-pro-Correct-the-battery-s.patch
        ${FILESDIR}/0053-arm64-dts-rk3399-pinephone-pro-Cleanup-some-USB-node.patch
        ${FILESDIR}/0054-arm64-dts-rk3399-pinephone-pro-Fix-PDOs-to-be-more-r.patch
        ${FILESDIR}/0055-arm64-dts-rk3399-pinephone-pro-Add-chassis-type-hand.patch
        ${FILESDIR}/0056-arm64-dts-rk3399-pinephone-pro-Add-mmc-aliases-to-ge.patch
        ${FILESDIR}/0057-arm64-dts-rk3399-pinephone-pro-Use-a-new-rk818-batte.patch
        ${FILESDIR}/0058-arm64-dts-rk3399-pinephone-pro-Full-support-for-Type.patch
        ${FILESDIR}/0059-arm64-dts-rk3399-pinephone-pro-Use-DCLK_VOP-_FRAC-to.patch
        ${FILESDIR}/0060-arm64-dts-rk3399-pinephone-pro-Add-support-for-power.patch
        ${FILESDIR}/0061-arm64-dts-rk3399-pinephone-pro-Add-audio-support.patch
        ${FILESDIR}/0062-arm64-dts-rk3399-pinephone-pro-Add-flash-and-fix-led.patch
        ${FILESDIR}/0063-arm64-dts-rk3399-pinephone-pro-add-modem-RI-pin.patch
        ${FILESDIR}/0064-arm64-dts-rk3399-pinephone-pro-improve-sound-device.patch
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
