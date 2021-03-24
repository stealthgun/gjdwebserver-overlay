# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit gnome2 readme.gentoo-r1 systemd toolchain-funcs udev vala

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/ModemManager/"
SRC_URI="https://www.freedesktop.org/software/ModemManager/ModemManager-${PV}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/1" # subslot = dbus interface version, i.e. N in org.freedesktop.ModemManager${N}
KEYWORDS="~arm64"

IUSE="elogind +introspection mbim policykit +qmi systemd +udev vala"
REQUIRED_USE="
	?? ( elogind systemd )
	vala? ( introspection )
"

DEPEND="
	>=dev-libs/glib-2.48.0:2
	udev? ( >=dev-libs/libgudev-230:= )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6:= )
	mbim? ( >=net-libs/libmbim-1.24.0 )
	policykit? ( >=sys-auth/polkit-0.106[introspection] )
	qmi? ( >=net-libs/libqmi-1.26.0:= )
	elogind? ( sys-auth/elogind )
	systemd? ( >=sys-apps/systemd-209 )
"
RDEPEND="${DEPEND}
	policykit? ( acct-group/plugdev )
"
BDEPEND="
	dev-util/gdbus-codegen
	dev-util/glib-utils
	>=dev-util/gtk-doc-am-1
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"
PATCHES="
	${FILESDIR}/0001-mm-broadband-modem-improve-voice-capabilities-detect.patch
	${FILESDIR}/0004-broadband-modem-qmi_Enable_AT_URCs_and_QMI_indications.patch
	${FILESDIR}/temp_modemmanager_rpmsg.patch
"

S="${WORKDIR}/ModemManager-${PV}"

src_prepare() {
	DOC_CONTENTS="
		If your USB modem shows up only as a storage device when you plug it in,
		then you should install sys-apps/usb_modeswitch, which will automatically
		switch it over to USB modem mode whenever you plug it in.\n"

	if use policykit; then
		DOC_CONTENTS+="\nTo control your modem without needing to enter the root password,
			add your user account to the 'plugdev' group."
	fi

	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	local myconf=(
		--disable-Werror
		--disable-static
		--with-dist-version=${PVR}
		--with-udev-base-dir="$(get_udevdir)"
		$(use_with udev)
		$(use_enable introspection)
		$(use_with mbim)
		$(use_with policykit polkit)
		$(use_with systemd systemd-suspend-resume)
		$(use_with systemd systemd-journal)
		$(use_with qmi)
		$(use_enable vala)
	)
	if use elogind; then
		local pkgconfig="$(tc-getPKG_CONFIG)"
		myconf+=(
			--with-systemd-suspend-resume
			LIBSYSTEMD_LOGIN_CFLAGS="$(${pkgconfig} --cflags "libelogind")"
			LIBSYSTEMD_LOGIN_LIBS="$(${pkgconfig} --libs "libelogind")"
		)
	fi
	gnome2_src_configure "${myconf[@]}"
}

src_install() {
	gnome2_src_install

	# Allow users in plugdev group full control over their modem
	if use policykit; then
		insinto /usr/share/polkit-1/rules.d/
		doins "${FILESDIR}"/01-org.freedesktop.ModemManager1.rules
		insinto /usr/lib/udev/rules.d/
		newins "${FILESDIR}"/rpmsg-udev.rules 80-modemmanager-mjr.rules 
	fi
	# Disable suspend/resume hooks for the EG25-G modem in the PinePhone
	sed -i -e 's|bin/ModemManager|bin/ModemManager --test-no-suspend-resume|g' \         "${D}/lib/systemd/system/ModemManager.service"
	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst

	# The polkit rules file moved to /usr/share
	old_rules="${EROOT}/etc/polkit-1/rules.d/01-org.freedesktop.ModemManager.rules"
	if [[ -f "${old_rules}" ]]; then
		case "$(md5sum ${old_rules})" in
		  c5ff02532cb1da2c7545c3069e5d0992* | 5c50f0dc603c0a56e2851a5ce9389335* )
			# Automatically delete the old rules.d file if the user did not change it
			elog
			elog "Removing old ${old_rules} ..."
			rm -f "${old_rules}" || eerror "Failed, please remove ${old_rules} manually"
			;;
		  * )
			elog "The ${old_rules}"
			elog "file moved to /usr/share/polkit-1/rules.d/ in >=modemmanager-0.5.2.0-r2"
			elog "If you edited ${old_rules}"
			elog "without changing its behavior, you may want to remove it."
			;;
		esac
	fi

	if ! use udev; then
		ewarn "You have built ModemManager without udev support. You may have to teach it"
		ewarn "about your modem port manually."
	fi

	systemd_reenable ModemManager.service

	readme.gentoo_print_elog
}
