# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Firmwares files for PinePhone"
HOMEPAGE="https://xff.cz/git/linux-firmware"
SRC_URI="https://xff.cz/git/linux-firmware/tree/ov5640_af.bin?id=4ec2645b007ba4c3f2962e38b50c06f274abbf7c -> ov5640_af.bin
https://xff.cz/git/linux-firmware/tree/anx7688-fw.bin?id=4ec2645b007ba4c3f2962e38b50c06f274abbf7c -> anx7688-fw.bin
https://xff.cz/git/linux-firmware/tree/rtl_bt/rtl8723cs_xx_fw.bin?id=4ec2645b007ba4c3f2962e38b50c06f274abbf7c -> rtl8723cs_xx-fw.bin
"

LICENSE="linux-fw-redistributable no-source-code"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}"

src_install() {
	mkdir -p "${D}"/lib/firmware/ || die
	cp "${S}"/anx7688-fw.bin /lib/firmware/
	cp "${S}"/ov5640_af.bin /lib/firmware/
	cp "${S}"/rtl8723cs_xx-fw.bin /lib/firmware/
}
