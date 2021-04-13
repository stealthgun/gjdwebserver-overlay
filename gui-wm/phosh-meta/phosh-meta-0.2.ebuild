# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Phosh"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE=""

DEPEND="
		gui-wm/phosh
		net-voip/calls
		net-im/chatty
		net-dns/dnsmasq
		app-editors/gedit
		dev-libs/libwacom
		media-libs/grilo
		gnome-base/gnome-control-center
		gnome-extra/gnome-contacts
		media-video/megapixels
		gnome-extra/gnome-calculator
		gnome-extra/gnome-calendar
		www-client/epiphany
		app-mobilephone/flashlight
		x11-terms/gnome-terminal
		x11-themes/sound-theme-librem5
		app-text/evince
		app-editors/gedit
		sys-power/gtherm
		sys-auth/rtkit
		>=x11-libs/pango-1.46
		mail-client/geary
		sci-geosciences/gnome-maps
		gnome-extra/portfolio
		gnome-extra/gnome-weather
		x11-misc/squeekboard
		www-client/chromium-bin
		media-sound/lollypop
		app-text/evince
		gnome-extra/postmarketos-tweaks
		>=x11-themes/adwaita-icon-theme-40
		>=x11-themes/gnome-backgrounds-40
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

