# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ec0ef36b8b897ed1ae6bb0d0de13d5776f5d3659"

DESCRIPTION="ALSA ucm configuration files for the PinePhone (Pro)"
HOMEPAGE="https://gitlab.com/pine64-org/pine64-alsa-ucm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	>=media-libs/alsa-topology-conf-1.2.5
	>=media-libs/alsa-lib-1.2.6
	>=media-plugins/alsa-plugins-1.2.6
	>=media-libs/alsa-ucm-conf-1.2.6
	>=media-video/pipewire-0.3.42
	"

DEPEND="${RDEPEND}"

BDEPEND="${RDEPEND}"

src_install() {
	insinto /usr/share/alsa/ucm2/PinePhone/HiFi.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhone/PinePhone-HiFi.conf
	
	insinto /usr/share/alsa/ucm2/PinePhone/VoiceCall.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhone/PinePhone-VoiceCall.conf
	
	insinto /usr/share/alsa/ucm2/PinePhone/PinePhone.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhone/PinePhone.conf
		
	insinto /usr/share/alsa/ucm2/PinePhonePro/HiFi.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhonePro/PinePhonePro-HiFi.conf
	
	insinto /usr/share/alsa/ucm2/PinePhonePro/VoiceCall.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhonePro/PinePhonePro-VoiceCall.conf
	
	insinto /usr/share/alsa/ucm2/PinePhonePro/PinePhonePro.conf
	insopts -m644
	doins -r "${FILESDIR}"/ucm2/PinePhonePro/PinePhonePro.conf
	
	dosym /usr/share/alsa/ucm2/PinePhone/PinePhone.conf \
	        /usr/share/alsa/ucm2/conf.d/simple-card/PinePhone.conf
	        
	dosym /usr/share/alsa/ucm2/PinePhonePro/PinePhonePro.conf \
	        /usr/share/alsa/ucm2/conf.d/simple-card/PinePhonePro.conf

}
