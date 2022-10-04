# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Gnome Mobile"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64 ~arm"
IUSE="cawbird chromium firefox geary lollypop owncloud nextcloud voicemail accessibility +bluetooth +classic cups python"
DEPEND="
		>=dev-libs/glib-2.70.2:2
		>=x11-libs/gdk-pixbuf-2.42.6:2
		>=x11-libs/pango-1.48.10
		>=x11-libs/gtk+-3.24.31:3[cups?]
		>=dev-libs/atk-2.36.0
		>=gnome-base/librsvg-2.52.5
		>=gnome-base/gnome-desktop-43:3

		>=gnome-base/gvfs-1.48.1
		>=gnome-base/dconf-0.40.0

		>=media-libs/gstreamer-1.16.2:1.0
		>=media-libs/gst-plugins-base-1.16.2:1.0
		>=media-libs/gst-plugins-good-1.16.2:1.0

		python? ( >=dev-python/pygobject-3.42.0:3 )
		
		>=gnome-base/gdm-43.0

		>=x11-wm/mutter-43[mobile]
		>=gnome-base/gnome-shell-43[mobile]
		>=media-fonts/cantarell-0.301

		>=x11-themes/gnome-backgrounds-40.0
		x11-themes/sound-theme-freedesktop

		accessibility? (
			>=app-accessibility/at-spi2-atk-2.38.0
			>=app-accessibility/at-spi2-core-2.40.0
			>=app-accessibility/orca-40.0
			>=gnome-extra/mousetweaks-3.32.0
		)

		>=gnome-base/gnome-session-40.1.1
		>=gnome-base/gnome-settings-daemon-41.0[cups?]
		>=gnome-base/gnome-control-center-41.2[cups?]
		>=gnome-extra/gnome-color-manager-3.36.0

		>=app-crypt/gcr-3.40.0
		>=gnome-base/nautilus-41.1
		>=gnome-base/gnome-keyring-40.0
		>=gnome-extra/evolution-data-server-3.42.3

		>=app-crypt/seahorse-41.0
		>=app-editors/gedit-41
		>=app-text/evince-41.3
		>=gnome-extra/gnome-contacts-41.0
		>=media-gfx/eog-41.1
		>=media-video/totem-3.38.2
		>=x11-terms/gnome-terminal-3.42.2

		>=gnome-extra/gnome-user-docs-41.1
		>=gnome-extra/yelp-41.2

		>=x11-themes/adwaita-icon-theme-41.0

		bluetooth? ( >=net-wireless/gnome-bluetooth-3.34.5 )
		
		classic? ( >=gnome-extra/gnome-shell-extensions-43.0 )
	
		gnome-extra/phosh-antispam
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
		media-gfx/gnome-screenshot
		sys-process/gnome-usage
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
		gnome-extra/sushi
		media-gfx/eog
		
		cawbird? (
			net-im/cawbird
		)
		
		
		chromium? (
			www-client/chromium
		)
		
		firefox? (
			www-client/firefox
		)
		
		
		geary? (	
			mail-client/geary
		)		
		
		lollypop? (	
			media-sound/lollypop
		)
					
		owncloud? (
			net-misc/owncloud-client
		)
		
		nextcloud? (
			net-misc/nextcloud-client
		)
		
		voicemail? (
			gnome-extra/vvmplayer
		)
"

RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND=">=gnome-base/gvfs-1.48.0[udisks]"

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
	
	# Remind people where to find our project information
	elog "Please remember to look at https://wiki.gentoo.org/wiki/Project:GNOME"
	elog "for information about the project and documentation."
}
