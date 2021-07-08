# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Firebird RDBMS bindings for Python."
HOMEPAGE="https://pypi.org/project/fdb"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"

RDEPEND="dev-db/firebird"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
