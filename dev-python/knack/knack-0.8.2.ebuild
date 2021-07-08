# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A Command-Line Interface framework"
HOMEPAGE="https://pypi.org/project/knack"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/tabulate[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.2[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.1[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
