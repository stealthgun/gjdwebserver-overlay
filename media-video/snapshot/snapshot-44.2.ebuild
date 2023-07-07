# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License-2

EAPI=8
CRATES="
  autocfg-1.1.0
  cfg-if-1.0.0
  pin-utils-0.1.0
  dlib-0.5.0
  field-offset-0.3.5
  form_urlencoded-1.1.0
  ctor-0.1.26
  crypto-common-0.1.6
  scoped-tls-1.0.1
  cairo-sys-rs-0.17.0
  async-recursion-1.0.4
  proc-macro-error-1.0.4
  serde_repr-0.1.12
  version_check-0.9.4
  serde_spanned-0.6.1
  sha1-0.10.5
  gsk4-sys-0.6.3
  memoffset-0.8.0
  gdk-pixbuf-sys-0.17.0
  quote-1.0.26
  futures-core-0.3.28
  gdk4-wayland-0.6.3
  xdg-home-1.0.0
  muldiv-1.0.1
  thread_local-1.1.7
  futures-io-0.3.28
  memoffset-0.7.1
  graphene-sys-0.17.0
  temp-dir-0.1.11
  gdk4-x11-sys-0.6.3
  async-trait-0.1.68
  async-lock-2.7.0
  bitflags-1.3.2
  tracing-log-0.1.3
  tinyvec_macros-0.1.1
  rand_chacha-0.3.1
  proc-macro-error-attr-1.0.4
  downcast-rs-1.2.0
  gdk4-wayland-sys-0.6.3
  pretty-hex-0.3.0
  zbus_names-2.5.0
  waker-fn-1.1.0
  wayland-sys-0.30.1
  event-listener-2.5.3
  futures-executor-0.3.28
  iana-time-zone-0.1.56
  futures-macro-0.3.28
  graphene-rs-0.17.1
  lazy_static-1.4.0
  gstreamer-gl-x11-0.20.0
  gobject-sys-0.17.4
  hex-0.4.3
  zvariant_utils-1.0.0
  async-global-executor-2.3.1
  zvariant_derive-3.12.0
  gstreamer-gl-egl-0.20.0
  generic-array-0.14.7
  thiserror-impl-1.0.40
  parking-2.1.0
  concurrent-queue-2.2.0
  enumflags2-0.7.7
  semver-1.0.17
  num-integer-0.1.45
  gstreamer-gl-wayland-sys-0.20.0
  libloading-0.7.4
  version-compare-0.1.1
  gstreamer-gl-x11-sys-0.20.0
  heck-0.4.1
  toml_datetime-0.6.1
  locale_config-0.3.0
  async-fs-1.6.0
  gstreamer-gl-egl-sys-0.20.0
  enumflags2_derive-0.7.7
  thiserror-1.0.40
  static_assertions-1.1.0
  gdk-pixbuf-0.17.0
  futures-channel-0.3.28
  crossbeam-utils-0.8.15
  futures-task-0.3.28
  indexmap-1.9.3
  slab-0.4.8
  pin-project-lite-0.2.9
  async-channel-1.8.0
  byteorder-1.4.3
  io-lifetimes-1.0.10
  atomic-waker-1.1.1
  ordered-stream-0.2.0
  ppv-lite86-0.2.17
  libadwaita-sys-0.4.1
  unicode-ident-1.0.8
  pango-sys-0.17.0
  nu-ansi-term-0.46.0
  gstreamer-base-sys-0.20.0
  atomic_refcell-0.1.10
  overload-0.1.1
  option-operations-0.5.0
  serde_derive-1.0.160
  toml-0.7.3
  digest-0.10.6
  num-rational-0.4.1
  percent-encoding-2.2.0
  socket2-0.4.9
  zbus_macros-3.12.0
  pkg-config-0.3.26
  system-deps-6.0.5
  derivative-2.2.0
  unicode-bidi-0.3.13
  typenum-1.16.0
  smallvec-1.10.0
  async-io-1.13.0
  glib-macros-0.17.9
  gstreamer-base-0.20.5
  anyhow-1.0.70
  getrandom-0.2.9
  target-lexicon-0.12.7
  once_cell-1.17.1
  rand-0.8.5
  pango-0.17.4
  tracing-attributes-0.1.24
  value-bag-1.0.0-alpha.9
  memchr-2.5.0
  proc-macro-crate-1.3.1
  serde-1.0.160
  gstreamer-audio-0.20.4
  wayland-scanner-0.30.0
  polling-2.8.0
  gio-sys-0.17.4
  wayland-client-0.30.1
  paste-1.0.12
  gstreamer-pbutils-0.20.5
  gstreamer-pbutils-sys-0.20.0
  gstreamer-video-sys-0.20.0
  gstreamer-sys-0.20.0
  gstreamer-gl-0.20.0
  gtk4-sys-0.6.3
  proc-macro2-1.0.56
  tracing-core-0.1.30
  hashbrown-0.12.3
  glib-sys-0.17.4
  async-task-4.4.0
  num-traits-0.2.15
  cfg-expr-0.15.1
  gdk4-sys-0.6.3
  wayland-backend-0.1.2
  url-2.3.1
  cc-1.0.79
  libadwaita-0.4.1
  futures-lite-1.13.0
  tinyvec-1.6.0
  sharded-slab-0.1.4
  cairo-rs-0.17.0
  gstreamer-video-0.20.4
  rand_core-0.6.4
  gstreamer-gl-sys-0.20.0
  tracing-0.1.38
  zvariant-3.12.0
  ashpd-0.4.0
  gdk4-0.6.3
  kv-log-macro-1.0.7
  gstreamer-audio-sys-0.20.0
  gst-plugin-gtk4-0.10.5
  futures-sink-0.3.28
  toml_edit-0.19.8
  async-executor-1.5.1
  async-broadcast-0.5.1
  blocking-1.3.1
  log-0.4.17
  gsk4-0.6.3
  chrono-0.4.24
  gtk4-macros-0.6.6
  futures-util-0.3.28
  block-buffer-0.10.4
  gstreamer-gl-wayland-0.20.0
  cpufeatures-0.2.7
  rustc_version-0.4.0
  unicode-normalization-0.1.22
  fastrand-1.9.0
  gettext-rs-0.7.0
  gio-0.17.9
  gst-plugin-version-helper-0.7.5
  gdk4-x11-0.6.3
  winnow-0.4.1
  zbus-3.12.0
  idna-0.3.0
  aho-corasick-1.0.1
  quick-xml-0.23.1
  tracing-subscriber-0.3.17
  nix-0.26.2
  syn-2.0.15
  glib-0.17.9
  regex-1.8.1
  async-std-1.12.0
  syn-1.0.109
  rustix-0.37.15
  regex-syntax-0.7.1
  gstreamer-0.20.5
  gtk4-0.6.6
  libc-0.2.142
  linux-raw-sys-0.3.4
  gettext-sys-0.21.3
"

inherit cargo gnome2-utils meson toolchain-funcs xdg

DESCRIPTION="Gnome Camera Application"
HOMEPAGE="https://gitlab.gnome.org/GNOME/Incubator/snapshot"
SRC_URI="https://gitlab.gnome.org/GNOME/Incubator/snapshot/-/archive/${PV}/snapshot-${PV}.tar.gz"
SRC_URI+=" $(cargo_crate_uris ${CRATES})"

#RESTRICT="network-sandbox"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	>=x11-libs/gtk+-3.0
	>=gui-libs/libadwaita-1.4.0_alpha
	>=media-libs/gstreamer-1.20.0
	media-video/wireplumber
	media-video/pipewire[gstreamer]
"
RDEPEND="${DEPEND}"
BDEPEND=""

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
