# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev systemd git-r3

DESCRIPTION="A collection of scripts for setting up the PinePhone's modem"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/pinephone-modem-scripts"
EGIT_REPO_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/pinephone/pinephone-modem-scripts"
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
	udev_dorules ${FILESDIR}/*.rules

	systemd_dounit ${FILESDIR}/*.service
	dobin ${FILESDIR}/pinephone-modem-setup.sh
}
