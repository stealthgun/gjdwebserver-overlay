# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Microsoft app configuration data library for Python"
HOMEPAGE="https://pypi.org/project/azure-appconfiguration"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="+async"

RDEPEND=">=dev-python/azure-core-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/msrest-0.6.18[${PYTHON_USEDEP}]
	async? ( >=dev-python/aiohttp-3.0[${PYTHON_USEDEP}]
			>=dev-python/aiodns-2.0[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
