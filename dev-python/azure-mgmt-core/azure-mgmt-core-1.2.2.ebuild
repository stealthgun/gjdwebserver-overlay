# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure management core library for Python"
HOMEPAGE="https://pypi.org/project/azure-mgmt-core"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/azure-core-1.9.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
