# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

COMMIT="8517026415e75a8eec567774072cbbbbb52376c1"

DESCRIPTION="Cross-platform library for building Telegram clients"
HOMEPAGE="https://github.com/tdlib/td"
SRC_URI="https://github.com/tdlib/td/archive/${COMMIT}.tar.gz"

KEYWORDS="~amd64 ~arm64 ~arm ~x86"
SLOT="0"

S="${WORKDIR}/td-${COMMIT}"

DEPEND="
	dev-libs/openssl
	sys-libs/zlib	
	dev-util/gperf
	dev-util/cmake
"


RDEPEND="
	${DEPEND}
"
BDEPEND="
	${DEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake_src_configure
}
