# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev systemd git-r3

DESCRIPTION="Modem scripts for the PinePhone"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts.git"
EGIT_REPO_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts.git"
EGIT_BRANCH=eg25-manager

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"
IUSE="ofono"

DEPEND="	net-dialup/atinout
		sci-geosciences/gpsd
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	# fix path
	default
	sed -e s/bin/sbin/g -i gpsd-pinephone.service
}

src_install() {
	udev_dorules ${S}/*.rules

#	exeinto /etc/gpsd/
#	newexe  ${S}/gpsd_device-hook.sh device-hook
#	systemd_dounit ${S}/*.service
	dobin ${S}/pinephone-modem-setup.sh
	#dobin ${S}/pinephone-modem-setup-ofono.sh
}
