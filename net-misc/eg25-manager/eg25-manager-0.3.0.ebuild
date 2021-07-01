# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 systemd

DESCRIPTION="Daemon for managing the Quectel EG25 modem"
HOMEPAGE="https://gitlab.com/mobian1/devices/eg25-manager"


KEYWORDS="~arm64"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} != 9999 ]]; then
	EGIT_COMMIT="73e16f76994b1d3c587796a35766cc668e30c0cd"
else
	KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
		dev-libs/libgpiod
		virtual/libusb:1
		net-misc/modemmanager
		"
RDEPEND="${DEPEND}"

PATCHES=(
	#	${FILESDIR}/11.patch
	#	${FILESDIR}/12.patch
)

src_install() {
	meson_src_install
	systemd_dounit "${FILESDIR}"/eg25-manager.service
	insinto /etc/eg25-manager
	newins "${FILESDIR}"/eg25-pinephone-1.0.toml pine64,pinephone-1.0.toml
	newins "${FILESDIR}"/eg25-pinephone-1.1.toml pine64,pinephone-1.1.toml
	newins "${FILESDIR}"/eg25-pinephone-1.2.toml pine64,pinephone-1.2.toml
}

pkg_postinst() {
	systemd_reenable --all eg25-manager
}

