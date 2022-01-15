# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ec0ef36b8b897ed1ae6bb0d0de13d5776f5d3659"

DESCRIPTION="ALSA ucm configuration files for the PinePhone (Pro)"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"
SRC_URI="https://gitlab.com/pine64-org/pine64-alsa-ucm/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-topology-conf-1.2.5
	>=media-libs/alsa-lib-1.2.6
	>=media-plugins/alsa-plugins-1.2.6
	>=media-libs/alsa-ucm-conf-1.2.6
	"

DEPEND="${RDEPEND}"

BDEPEND="${RDEPEND}"

S="${WORKDIR}/pine64-alsa-ucm-${COMMIT}"

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone
	insopts -m644
	doins -r "${S}"/ucm2/PinePhone/*.conf
	
	insinto /usr/share/alsa/ucm2/PinePhonePro
	insopts -m644
	doins -r "${S}"/ucm2/PinePhonePro/*.conf
	
	dosym /usr/share/alsa/ucm2/PinePhone/PinePhone.conf \
	        /usr/share/alsa/ucm2/conf.d/simple-card/PinePhone.conf
	        
	dosym /usr/share/alsa/ucm2/PinePhonePro/PinePhonePro.conf \
	        /usr/share/alsa/ucm2/conf.d/simple-card/PinePhonePro.conf

}
