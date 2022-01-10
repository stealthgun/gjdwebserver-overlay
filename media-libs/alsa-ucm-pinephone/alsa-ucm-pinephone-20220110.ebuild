# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ec0ef36b8b897ed1ae6bb0d0de13d5776f5d3659"

DESCRIPTION="ALSA ucm configuration files for PinePhone bases on the Manjaro ARM repo"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"
SRC_URI="https://gitlab.com/pine64-org/pine64-alsa-ucm/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-ucm-conf-1.2.6
	"

DEPEND="${RDEPEND}"

BDEPEND="${RDEPEND}"

S="${WORKDIR}/alsa-ucm-pinephone-${COMMIT}"

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone
	doins -r "${S}"/ucm2/PinePhone/*.conf
	
	insinto /usr/share/alsa/ucm2/PinePhonePro
	doins -r "${S}"/ucm2/PinePhonePro/*.conf
}
