# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd xdg-utils meson

VALA_USE_DEPEND="vapigen"

DESCRIPTION="D-Bus abstraction for enumerating power devices, querying history and statistics"
HOMEPAGE="https://upower.freedesktop.org/"
SRC_URI="https://gitlab.freedesktop.org/upower/upower/-/archive/v0.99.14/upower-v0.99.14.tar.gz"

# No tarball released at the usual location
#SRC_URI="https://${PN}.freedesktop.org/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0/3" # based on SONAME of libupower-glib.so
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~mips ~ppc ppc64 ~riscv ~sparc ~x86"

# gtk-doc files are not available as prebuilt in the tarball
IUSE="doc +introspection ios selinux vala"

DEPEND="
	>=dev-libs/glib-2.38:2
	sys-apps/dbus:=
	introspection? ( dev-libs/gobject-introspection:= )
	kernel_linux? (
		>=dev-libs/libgudev-236:=
		virtual/udev
		ios? (
			>=app-pda/libimobiledevice-1:=
			>=app-pda/libplist-2:=
		)
	)
	vala? ( $(vala_depend) )
"
RDEPEND="${DEPEND}
	selinux? ( sec-policy/selinux-devicekit )
"
BDEPEND="
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )
"

QA_MULTILIB_PATHS="usr/lib/${PN}/.*"

DOCS=( AUTHORS HACKING NEWS README )

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	eapply_user
	use vala && vala_src_prepare
	xdg_environment_reset
}

src_configure() {
	local backend

	if use kernel_linux ; then
		backend=linux
	else
		backend=dummy
	fi

	local myeconfargs=(
		--disable-tests
		--enable-man-pages
		--libexecdir="${EPREFIX}"/usr/lib/${PN}
		--localstatedir="${EPREFIX}"/var
		--with-backend=${backend}
		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
		--with-systemdutildir="$(systemd_get_utildir)"
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		$(use_with ios idevice)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	meson_src_install
	find "${ED}" -type f -name '*.la' -delete || die
	keepdir /var/lib/upower #383091
}

pkg_postinst() {
	if [[ ${REPLACING_VERSIONS} ]] && ver_test ${REPLACING_VERSIONS} -lt 0.99.12; then
		elog "Support for Logitech Unifying Receiver battery state readout was"
		elog "removed in version 0.99.12, these devices have been directly"
		elog "supported by the Linux kernel since version >=3.2."
		elog
		elog "Support for CSR devices battery state was removed from udev rules"
		elog "in version 0.99.12. This concerns the following Logitech products"
		elog "from the mid 2000s:"
		elog "Mouse/Dual/Keyboard+Mouse Receiver, Freedom Optical, Elite Duo,"
		elog "MX700/MX1000, Optical TrackMan, Click! Mouse, Presenter."
	fi
}
