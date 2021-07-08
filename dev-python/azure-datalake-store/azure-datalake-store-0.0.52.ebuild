# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Azure Data Lake Store Filesystem Client Library for Python"
HOMEPAGE="https://pypi.org/project/azure-datalake-store"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="virtual/python-cffi[${PYTHON_USEDEP}]
	>=dev-python/adal-1.2.6[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	default
	sed -i -e 's:store/\*.py:store \*.py:' MANIFEST.in || die
}
