# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Autorebuild documentation on change"
HOMEPAGE="https://github.com/GaretJax/sphinx-autobuild"
SRC_URI="https://github.com/GaretJax/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/argh-0.24.1[${PYTHON_USEDEP}]
	>=dev-python/livereload-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/pathtools-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/port-for-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=www-servers/tornado-3.2[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.7.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
