# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..11} )
PYTHON_REQ_USE="xml(+)"

XORG_TARBALL_SUFFIX="xz"
XORG_MULTILIB=yes
XORG_DOC=doc

inherit python-any-r1 xorg-3

DESCRIPTION="X C-language Bindings library error module"
HOMEPAGE="https://xcb.freedesktop.org/ https://gitlab.freedesktop.org/xorg/lib/libxcb"
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-errors/-/archive/${PV}/libxcb-errors-${PV}.zip"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0/1.12"

RDEPEND="
	x11-libs/libxcb
"

#src_configure() {
	#xorg-3_src_configure
#}

