# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8} )
VALA_MIN_API_VERSION="0.40"

inherit bash-completion-r1 gnome.org gnome2-utils linux-info meson python-any-r1 systemd vala xdg

DESCRIPTION="A tagging metadata database, search tool and indexer (virtual)"
HOMEPAGE="https://wiki.gnome.org/Projects/Tracker"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="3/3.0"
IUSE="gtk-doc +miners networkmanager stemmer test example"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
#RESTRICT="!test? ( test )"

PV_SERIES=$(ver_cut 1-2)

# In 2.2.0 util-linux should only be necessary if glib is older than 2.52 at compile-time
# But build still needs it - https://gitlab.gnome.org/GNOME/tracker/issues/131
# FIXME: need ln -s /usr/share/asciidoc to /etc/asciidoc to compile
RDEPEND="
	>=dev-libs/glib-2.46:2
	>=sys-apps/dbus-1.3.2
	>=dev-libs/gobject-introspection-1.54:=
	>=dev-libs/icu-4.8.1.2:=
	>=dev-libs/json-glib-1.0
	>=net-libs/libsoup-2.40.1:2.4
	>=dev-libs/libxml2-2.7
	>=dev-db/sqlite-3.20.0
	networkmanager? ( >=net-misc/networkmanager-0.8 )
	stemmer? ( dev-libs/snowball-stemmer )
	sys-apps/util-linux
	>=dev-python/snowballstemmer-2.1.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/glib-utils
	$(vala_depend)
	gtk-doc? ( >=dev-util/gtk-doc-1.8
		app-text/docbook-xml-dtd:4.1.2
		app-text/docbook-xml-dtd:4.5 )
	>=sys-devel/gettext-0.19.8
	>=app-text/asciidoc-9.1.0
	virtual/pkgconfig
	${PYTHON_DEPS}
"
PDEPEND="miners? ( >=app-misc/tracker-miners-${PV_SERIES} )"
