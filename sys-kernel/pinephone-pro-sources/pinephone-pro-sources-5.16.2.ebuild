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

DESCRIPTION="Full sources for the Linux kernel with gentoo patchset and with Mobian patches for the PinePhone Pro"

SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

PATCHES=(
        # Mobian Patches
        "${FILESDIR}"/0001-base-property-Swap-order-of-search-for-connection-to.patch
        "${FILESDIR}"/0002-clk-rk3399-Export-SCLK_CIF_OUT_SRC-to-device-tree.patch
        "${FILESDIR}"/0003-media-rockchip-rga-Fix-probe-bugs.patch
        "${FILESDIR}"/0004-drm-dw-mipi-dsi-rockchip-Ensure-that-lane-is-properl.patch
        "${FILESDIR}"/0005-drm-rockchip-dw-mipi-dsi-Fix-missing-clk_disable_unp.patch
        "${FILESDIR}"/0006-drm-bridge-dw-mipi-dsi-Fix-enable-disable-of-dsi-con.patch
        "${FILESDIR}"/0007-drm-dw-mipi-dsi-rockchip-Never-allow-lane-bandwidth-.patch
        "${FILESDIR}"/0008-drm-rockchip-cdn-dp-Disable-CDN-DP-on-disconnect.patch
        "${FILESDIR}"/0009-video-fbdev-Add-events-for-early-fb-event-support.patch
        "${FILESDIR}"/0010-power-rk818-Configure-rk808-clkout2-function.patch
        "${FILESDIR}"/0011-power-rk818-battery-Add-battery-driver-for-RK818.patch
        "${FILESDIR}"/0012-power-supply-rk818-battery-Use-a-more-propper-compat.patch
        "${FILESDIR}"/0013-power-supply-core-Don-t-ignore-max_current-of-0-when.patch
        "${FILESDIR}"/0014-power-supply-rk818-charger-Implement-charger-driver-.patch
        "${FILESDIR}"/0015-usb-typec-fusb302-Set-the-current-before-enabling-pu.patch
        "${FILESDIR}"/0016-usb-typec-fusb302-Extend-debugging-interface-with-dr.patch
        "${FILESDIR}"/0017-usb-typec-fusb302-Retry-reading-of-CC-pins-status-if.patch
        "${FILESDIR}"/0018-usb-typec-fusb302-More-useful-of-logging-status-on-i.patch
        "${FILESDIR}"/0019-usb-typec-fusb302-Update-VBUS-state-even-if-VBUS-int.patch
        "${FILESDIR}"/0020-usb-typec-fusb302-Make-tcpm-fusb302-logs-less-pollut.patch
        "${FILESDIR}"/0021-usb-typec-fusb302-Add-OF-extcon-support.patch
        "${FILESDIR}"/0022-usb-typec-fusb302-Fix-register-definitions.patch
        "${FILESDIR}"/0023-usb-typec-fusb302-Clear-interrupts-before-we-start-t.patch
        "${FILESDIR}"/0024-usb-typec-typec-extcon-Add-typec-extcon-bridge-drive.patch
        "${FILESDIR}"/0025-phy-rockchip-typec-Make-sure-the-plug-orientation-is.patch
        "${FILESDIR}"/0026-media-i2c-imx258-Add-support-for-powerdown-gpio.patch
        "${FILESDIR}"/0027-media-i2c-imx258-Don-t-be-too-strict-about-clock-rat.patch
        "${FILESDIR}"/0028-media-i2c-imx258-Add-support-for-reset-gpio.patch
        "${FILESDIR}"/0029-media-i2c-imx258-Add-support-for-power-supplies.patch
        "${FILESDIR}"/0030-drm-panel-hx8394-Add-driver-for-HX8394-based-HannSta.patch
        "${FILESDIR}"/0031-drm-panel-hx8394-Improve-the-panel-driver-make-it-wo.patch
        "${FILESDIR}"/0032-drm-panel-hx8394-Fix-mode-clock-for-the-pinephone-pr.patch
        "${FILESDIR}"/0033-input-goodix-Add-option-to-power-off-the-controller-.patch
        "${FILESDIR}"/0034-input-goodix-Don-t-disable-regulators-during-suspend.patch
        "${FILESDIR}"/0035-input-touchscreen-goodix-Respect-IRQ-flags-from-DT-w.patch
        "${FILESDIR}"/0036-input-touchscreen-goodix-Add-support-for-GT1158.patch
        "${FILESDIR}"/0037-arm64-dts-rk3399-pinephone-pro-Add-support-for-Pinep.patch
        "${FILESDIR}"/0038-arm64-dts-rk3399-pinephone-pro-Fixup-DT-validation-i.patch
        "${FILESDIR}"/0039-arm64-dts-rk3399-pinephone-pro-Make-charging-and-per.patch
        "${FILESDIR}"/0040-arm64-dts-rk3399-pinephone-pro-Fix-goodix-toucscreen.patch
        "${FILESDIR}"/0041-arm64-dts-rk3399-pinephone-pro-Correct-the-pmu1830-i.patch
        "${FILESDIR}"/0042-arm64-dts-rk3399-pinephone-pro-Power-off-goodix-touc.patch
        "${FILESDIR}"/0043-arm64-dts-rk3399-pinephone-pro-Add-support-for-both-.patch
        "${FILESDIR}"/0044-arm64-dts-rk3399-pinephone-pro-Fix-SD-card-power-sup.patch
        "${FILESDIR}"/0045-arm64-dts-rk3399-pinephone-pro-Correct-the-battery-s.patch
        "${FILESDIR}"/0046-arm64-dts-rk3399-pinephone-pro-Cleanup-some-USB-node.patch
        "${FILESDIR}"/0047-arm64-dts-rk3399-pinephone-pro-Fix-PDOs-to-be-more-r.patch
        "${FILESDIR}"/0048-arm64-dts-rk3399-pinephone-pro-Add-chassis-type-hand.patch
        "${FILESDIR}"/0049-arm64-dts-rk3399-pinephone-pro-Add-mmc-aliases-to-ge.patch
        "${FILESDIR}"/0050-arm64-dts-rk3399-pinephone-pro-Use-a-new-rk818-batte.patch
        "${FILESDIR}"/0051-arm64-dts-rk3399-pinephone-pro-Full-support-for-Type.patch
        "${FILESDIR}"/0052-arm64-dts-rk3399-pinephone-pro-Use-DCLK_VOP-_FRAC-to.patch
        "${FILESDIR}"/0053-arm64-dts-rk3399-pinephone-pro-Add-support-for-power.patch
        "${FILESDIR}"/0054-arm64-dts-rk3399-pinephone-pro-Add-audio-support.patch
        "${FILESDIR}"/0055-arm64-dts-rk3399-pinephone-pro-Add-flash-and-fix-led.patch
        "${FILESDIR}"/0056-arm64-dts-rk3399-pinephone-pro-add-modem-RI-pin.patch
        "${FILESDIR}"/0057-arm64-dts-rk3399-pinephone-pro-improve-sound-device.patch
        "${FILESDIR}"/0058-arm64-dts-rk3399-pinephone-pro-remove-front-camera-n.patch
        "${FILESDIR}"/0059-power-supply-rk818-battery-Report-charging-status-ba.patch
        # Pinephone Keyboard
        "${FILESDIR}"/pp-keyboard.patch
        "${FILESDIR}"/ppp-keyboard.patch
        # https://gitlab.com/mobian1/issues/-/issues/389#note_811711315
        "${FILESDIR}"/mmc-core-wait-for-command-setting-Power-Off-Notification-bit-to-complete.patch
        # Bootsplash
        "${FILESDIR}"/0001-revert-garbage-collect-fbdev-scrolling-acceleration.patch
        "${FILESDIR}"/0002-revert-fbcon-remove-now-unusued-softback_lines-cursor-argument.patch
        "${FILESDIR}"/0003-revert-fbcon-remove-no-op-fbcon_set_origin.patch
        "${FILESDIR}"/0004-revert-fbcon-remove-soft-scrollback-code.patch
        "${FILESDIR}"/0001-bootsplash.patch
        "${FILESDIR}"/0002-bootsplash.patch
        "${FILESDIR}"/0003-bootsplash.patch
        "${FILESDIR}"/0004-bootsplash.patch
        "${FILESDIR}"/0005-bootsplash.patch
        "${FILESDIR}"/0006-bootsplash.patch
        "${FILESDIR}"/0007-bootsplash.patch
        "${FILESDIR}"/0008-bootsplash.patch
        "${FILESDIR}"/0009-bootsplash.patch
        "${FILESDIR}"/0010-bootsplash.patch
        "${FILESDIR}"/0011-bootsplash.patch
        "${FILESDIR}"/0012-bootsplash.patch
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
	einfo "# make INSTALL_MOD_PATH=/usr modules_intall"
	einfo "# make INSTALL_DTBS_PATH=/boot/dtbs dtbs_install"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}

