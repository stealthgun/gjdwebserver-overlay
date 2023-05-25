# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
   autocfg-1.1.0
   serde-1.0.163
   hashbrown-0.12.3
   pkg-config-0.3.27
   winnow-0.4.6
   target-lexicon-0.12.7
   indexmap-1.9.3
   smallvec-1.10.0
   heck-0.4.1
   cfg-expr-0.15.1
   version-compare-0.1.1
   proc-macro2-1.0.56
   quote-1.0.27
   unicode-ident-1.0.8
   libc-0.2.144
   memchr-2.5.0
   version_check-0.9.4
   futures-core-0.3.28
   syn-2.0.16
   anyhow-1.0.71
   proc-macro-error-attr-1.0.4
   slab-0.4.8
   syn-1.0.109
   futures-task-0.3.28
   futures-sink-0.3.28
   proc-macro-error-1.0.4
   futures-util-0.3.28
   futures-channel-0.3.28
   pin-project-lite-0.2.9
   once_cell-1.17.1
   pin-utils-0.1.0
   bitflags-1.3.2
   thiserror-1.0.40
   glob-0.3.1
   prettyplease-0.2.5
   clang-sys-1.6.1
   semver-1.0.17
   cfg-if-1.0.0
   minimal-lexical-0.2.1
   gio-0.17.9
   futures-io-0.3.28
   serde_spanned-0.6.1
   toml_datetime-0.6.1
   nom-7.1.3
   libloading-0.7.4
   toml_edit-0.19.8
   bindgen-0.65.1
   regex-syntax-0.7.1
   toml-0.7.3
   system-deps-6.1.0
   proc-macro-crate-1.3.1
   regex-1.8.1
   cexpr-0.6.0
   glib-sys-0.17.4
   gobject-sys-0.17.4
   gio-sys-0.17.4
   futures-macro-0.3.28
   thiserror-impl-1.0.40
   cairo-sys-rs-0.17.0
   pango-sys-0.17.0
   gdk-pixbuf-sys-0.17.0
   glib-macros-0.17.9
   graphene-sys-0.17.0
   gdk4-sys-0.6.3
   gsk4-sys-0.6.3
   gtk4-sys-0.6.3
   rustc-hash-1.1.0
   lazycell-1.3.0
   lazy_static-1.4.0
   peeking_take_while-0.1.2
   shlex-1.1.0
   rustc_version-0.4.0
   memoffset-0.8.0
   crc32fast-1.3.2
   fnv-1.0.7
   strsim-0.10.0
   futures-executor-0.3.28
   ident_case-1.0.1
   simd-adler32-0.3.5
   darling_core-0.20.1
   field-offset-0.3.5
   aho-corasick-1.0.1
   num-traits-0.2.15
   log-0.4.17
   adler-1.0.2
   glib-0.17.9
   miniz_oxide-0.7.1
   darling_macro-0.20.1
   rlottie-sys-0.2.7
   serde_derive-1.0.163
"

inherit gnome2-utils meson cargo

DESCRIPTION="Telegram client"
HOMEPAGE="https://github.com/paper-plane-developers/"
SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v0.1.0-beta.1.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris)"

#allready added for final release
#SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="CC-BY-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RESTRICT="network-sandbox"

S="${WORKDIR}/paper-plane-0.1.0-beta.1"
#S="${WORKDIR}/${PN}-${PV}"


DEPEND="
	>=gui-libs/libadwaita-1.4.0_alpha
	>=gui-libs/gtk-4.10.0
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-libav
	>=net-libs/td-1.8.14
	>=dev-util/blueprint-compiler-0.8.0
"

RDEPEND="${DEPEND}"

BDEPEND="${DEPEND}"
src_prepare() {
	default
	local emesonargs=(
		"-Dtg_api_id=25355557"
		"-Dtg_api_hash=5721a74e34aeb9d45c09a9ff51f14fdf"
	)	
	meson_src_configure

}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
