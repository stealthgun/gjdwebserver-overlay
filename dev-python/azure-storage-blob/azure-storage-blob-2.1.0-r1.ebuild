# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Azure client library that makes it easy to consume Azure Storage services"
HOMEPAGE="https://pypi.org/project/azure-storage-blob"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/azure-common-1.1.24[${PYTHON_USEDEP}]
	>=dev-python/azure-storage-common-2.1.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	!!dev-python/azure-storage
	dev-python/setuptools[${PYTHON_USEDEP}]"
