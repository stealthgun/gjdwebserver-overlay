# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Phosh without squeekboard"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="cawbird squeekboard chromium firefox vivaldi authenticator geary lollypop dino owncloud nextcloud"

DEPEND="
		gui-wm/phosh
		net-voip/gnome-calls
		net-im/chatty
		net-dns/dnsmasq
		app-editors/gedit
		app-misc/gnote
		media-video/megapixels
		gnome-base/gnome-control-center
		gnome-base/gnome-keyring
		gnome-extra/gnome-contacts
		gnome-extra/gnome-calculator
		gnome-extra/gnome-calendar
		gnome-extra/gnome-clocks
		gnome-extra/gnome-weather
		gnome-extra/portfolio 
		gnome-base/gnome-session
		gnome-extra/gnome-system-monitor
		gnome-extra/gnome-tweaks
		app-arch/file-roller
		sys-apps/gnome-disk-utility
		media-sound/gnome-sound-recorder
		www-client/epiphany
		sci-geosciences/gnome-maps
		x11-terms/gnome-terminal
		x11-themes/sound-theme-librem5
		app-text/evince
		sys-power/gtherm
		sys-auth/rtkit
		
		cawbird? (
			net-im/cawbird
		)
		
		squeekboard? (
			x11-misc/squeekboard
		)
		
		chromium? (
			www-client/chromium
		)
		
		firefox? (
			www-client/firefox
		)
		
		vivaldi? (
			www-client/vivaldi
		)
		
		authenticator? (
			gnome-extra/authenticator
		)			
		
		geary? (	
			mail-client/geary
		)		
		
		lollypop? (	
			media-sound/lollypop
		)
			
		dino? (
			net-im/dino-libhandy
		)
		
		owncloud? (
			net-misc/owncloud-client
		)
		
		nextcloud? (
			net-misc/nextcloud-client
		)
"

RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

pkg_postinst() {
	[ -e /usr/share/applications-bak ] || mkdir /usr/share/applications-bak
	for i in vim org.gnupg.pinentry-qt org.gnome.Extensions mupdf \
	gnome-printers-panel gnome-wifi-pannel pidgin wpa_gui cups \
	Gentoo-system-config-printer
	do
		if [ -e /usr/share/applications/$i.desktop ]; then
			mv /usr/share/applications/$i.desktop /usr/share/applications-bak
		fi
	done
}
