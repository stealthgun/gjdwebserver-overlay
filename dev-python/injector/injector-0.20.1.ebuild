# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 virtualx

DESCRIPTION="Injector - Python dependency injection framework, inspired by Guice"
HOMEPAGE="http://reactivex.io https://pypi.org/project/injector/"
SRC_URI="https://files.pythonhosted.org/packages/fe/c8/e8cf3e022453c7d120d323864ae6e278b287bdcdad6fdde980a3fdc9e443/injector-0.20.1.tar.gz"

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
