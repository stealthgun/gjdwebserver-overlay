# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 virtualx

DESCRIPTION="Reactive Extensions (Rx) for Python"
HOMEPAGE="http://reactivex.io https://pypi.org/project/Rx/"
SRC_URI="https://files.pythonhosted.org/packages/34/b5/e0f602453b64b0a639d56f3c05ab27202a4eec993eb64d66c077c821b621/Rx-3.2.0.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS=""

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest

src_test() {
	virtx distutils-r1_src_test
}
