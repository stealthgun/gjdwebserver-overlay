# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Cosmos DB SQL API client library for Python"
HOMEPAGE="https://pypi.org/project/azure-cosmos"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

# They fail.
RESTRICT="test"

RDEPEND=">=dev-python/msrestazure-0.6.4[${PYTHON_USEDEP}]
	>=dev-python/azure-common-1.1.27[${PYTHON_USEDEP}]"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	default
	sed -i -e "/find_package/ s:])):, 'samples', 'samples.*', 'doc'])):" setup.py || die
}

python_test() {
	"${EPYTHON}" -m unittest discover -s ./test -v -p '*.py' || die
}

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# __init__.py are provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die

	# Avoid portage file collisions
	rm -r "${ED}${PYTHON_SITEDIR}/azure/__pycache__" || die
}
