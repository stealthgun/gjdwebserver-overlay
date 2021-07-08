# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="scp module for paramiko"
HOMEPAGE="https://pypi.python.org/pypi/scp"
SRC_URI="mirror://pypi/s/scp/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
RESTRICT="test"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
