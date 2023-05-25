# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-v2

EAPI=8

CRATES="
  byteorder-1.4.3
  chrono-0.4.24
  darling-0.20.1
  cfg-if-1.0.0
  crc32fast-1.3.2
  time-core-0.1.1
  futures-channel-0.3.28
  version_check-0.9.4
  gdk4-sys-0.6.3
  toml_datetime-0.6.1
  utf8-width-0.1.6
  time-macros-0.2.9
  toml-0.7.3
  unicode-ident-1.0.8
  unicode-segmentation-1.10.1
  version-compare-0.1.1
  toml_edit-0.19.8
  winnow-0.4.6
  glob-0.3.1
  gtk4-macros-0.6.6
  bytemuck-1.13.1
  strsim-0.10.0
  temp-dir-0.1.11
  syn-2.0.16
  tdlib-tl-gen-0.5.0
  fnv-1.0.7
  syn-1.0.109
  itoa-1.0.6
  iana-time-zone-0.1.56
  lazycell-1.3.0
  rustc-hash-1.1.0
  proc-macro-error-attr-1.0.4
  pkg-config-0.3.27
  proc-macro-error-1.0.4
  serde_derive-1.0.163
  tdlib-tl-parser-0.2.0
  quote-1.0.27
  proc-macro2-1.0.56
  ryu-1.0.13
  serde-1.0.163
  serde_json-1.0.96
  memchr-2.5.0
  qrcodegen-1.8.0
  rlottie-sys-0.2.7
  lazy_static-1.4.0
  rustc_version-0.4.0
  num-rational-0.4.1
  minimal-lexical-0.2.1
  ident_case-1.0.1
  peeking_take_while-0.1.2
  regex-1.8.1
  regex-syntax-0.7.1
  serde_with_macros-2.3.3
  memoffset-0.8.0
  humantime-1.3.0
  env_logger-0.7.1
  tdlib-0.7.0
  slab-0.4.8
  libloading-0.7.4
  html-escape-0.2.13
  rlottie-0.5.2
  qrcode-generator-4.1.8
  hashbrown-0.12.3
  indexmap-1.9.3
  once_cell-1.17.1
  semver-1.0.17
  miniz_oxide-0.7.1
  pin-project-lite-0.2.9
  flate2-1.0.26
  pin-utils-0.1.0
  log-0.4.17
  proc-macro-crate-1.3.1
  glib-0.17.9
  heck-0.4.1
  hex-0.4.3
  serde_with-2.3.3
  serde_spanned-0.6.1
  rgb-0.8.36
  quick-error-1.2.3
  prettyplease-0.2.5
  gio-0.17.9
  target-lexicon-0.12.7
  thiserror-impl-1.0.40
  time-0.3.21
  libc-0.2.144
  gtk4-0.6.6
  jpeg-decoder-0.3.0
  aho-corasick-1.0.1
  darling_macro-0.20.1
  thiserror-1.0.40
  ellipse-0.2.0
  termcolor-1.2.0
  gettext-sys-0.21.3
  image-0.24.6
  pretty_env_logger-0.4.0
  png-0.17.8
  pango-0.17.4
  system-deps-6.1.0
  pango-sys-0.17.0
  locale_config-0.3.0
  gsk4-0.6.3
  cairo-rs-0.17.0
  smallvec-1.10.0
  simd-adler32-0.3.5
  gtk4-sys-0.6.3
  futures-util-0.3.28
  futures-task-0.3.28
  futures-sink-0.3.28
  futures-io-0.3.28
  futures-executor-0.3.28
  futures-core-0.3.28
  bindgen-0.65.1
  atty-0.2.14
  anyhow-1.0.71
  gsk4-sys-0.6.3
  graphene-sys-0.17.0
  graphene-rs-0.17.1
  gobject-sys-0.17.4
  gdk-pixbuf-0.17.0
  glib-sys-0.17.4
  bitflags-1.3.2
  base64-0.13.1
  autocfg-1.1.0
  num-traits-0.2.15
  num-integer-0.1.45
  nom-7.1.3
  futures-macro-0.3.28
  glib-macros-0.17.9
  gio-sys-0.17.4
  shlex-1.1.0
  gettext-rs-0.7.0
  gdk4-0.6.3
  gdk-pixbuf-sys-0.17.0
  field-offset-0.3.5
  futures-0.3.28
  fdeflate-0.3.0
  darling_core-0.20.1
  cexpr-0.6.0
  cfg-expr-0.15.1
  cc-1.0.79
  adler-1.0.2
  color_quant-1.1.0
  clang-sys-1.6.1
  cairo-sys-rs-0.17.0
"

declare -A GIT_CRATES=(
       [libadwaita]="https://gitlab.gnome.org/World/Rust/libadwaita-rs/-/archive/e6ec4f54f96362877175866ea864c8a5ecf31b5f/libadwaita-rs-e6ec4f54f96362877175866ea864c8a5ecf31b5f.tar.gz;rs-e6ec4f54f96362877175866ea864c8a5ecf31b5f"
)

inherit gnome2-utils meson cargo

DESCRIPTION="Telegram client"
HOMEPAGE="https://github.com/paper-plane-developers/"
SRC_URI="https://github.com/paper-plane-developers/${PN}/archive/refs/tags/v0.1.0-beta.1.tar.gz -> ${P}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

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

cargo_src_install(){
	cargo_src_install --path .
}

src_prepare() {
	default
	local emesonargs=(
		"-Dtg_api_id=25355557"
		"-Dtg_api_hash=5721a74e34aeb9d45c09a9ff51f14fdf"
	)	
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
