EAPI=8

inherit cargo

DESCRIPTION="Native YouTube Music desktop client"
HOMEPAGE="https://github.com/SimoHypers/limusic"
SRC_URI="https://github.com/SimoHypers/limusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/limusic-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="
	net-libs/nodejs
	|| ( sys-apps/pnpm-bin sys-apps/pnpm )
	dev-util/desktop-file-utils
	app-eselect/eselect-rust
"

DEPEND="
	dev-libs/openssl
	dev-libs/glib
	dev-libs/libayatana-appindicator
	dev-libs/libgudev
	gui-libs/gtk
	gui-libs/libadwaita
	net-libs/webkit-gtk
	media-video/mpv
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

src_unpack() {
  default
  tar xvf "${FILESDIR}/cargo-${PV}.tar.zst" || die
  unpack "${FILESDIR}/pnpm-store-${PV}.tar.xz"
}

src_prepare() {
  mkdir -p "${ECARGO_VENDOR}"
  rm -rf "${ECARGO_VENDOR}"
  ln -s "${WORKDIR}/vendor" "${ECARGO_VENDOR}" || die
  default
}

src_configure() {
  cargo_gen_config
}

src_compile() {
  cd "${S}/ui" || die
  XDG_CACHE_HOME="${WORKDIR}/pnpm-cache" \
    pnpm install --offline --frozen-lockfile \
    --store-dir "${WORKDIR}/pnpm-store" || die
  pnpm build || die

  cd "${S}" || die
  cargo_env cargo build --release --offline --locked \
    --manifest-path "${S}/src-tauri/Cargo.toml" || die
}

src_install() {
  newbin "${S}/src-tauri/target/release/limusic-app" limusic
}
