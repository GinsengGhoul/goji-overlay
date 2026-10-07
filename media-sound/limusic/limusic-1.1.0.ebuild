EAPI=8

inherit cargo

MECAB_IPADIC_VER="2.7.0-20070801"
LIBRUSTY_VER="130.0.7"

DESCRIPTION="Native YouTube Music desktop client"
HOMEPAGE="https://github.com/SimoHypers/limusic"
SRC_URI="
    https://github.com/SimoHypers/limusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
    https://github.com/lindera-morphology/mecab-ipadic/archive/refs/tags/${MECAB_IPADIC_VER}.tar.gz -> mecab-ipadic-${MECAB_IPADIC_VER}.tar.gz
    https://github.com/denoland/rusty_v8/releases/download/v${LIBRUSTY_VER}/librusty_v8_release_x86_64-unknown-linux-gnu.a.gz -> librusty_v8_release_x86_64-unknown-linux-gnu-v${LIBRUSTY_VER}.a.gz
"
PATCHES=(
)
S="${WORKDIR}/limusic-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

BDEPEND="
	net-libs/nodejs
	|| ( sys-apps/pnpm-bin sys-apps/pnpm )
	dev-util/desktop-file-utils
	app-eselect/eselect-rust
"

DEPEND="
	dev-libs/glib
	dev-libs/libayatana-appindicator
	dev-libs/libgudev
	dev-libs/openssl
	gui-libs/gtk
	gui-libs/libadwaita
	media-video/mpv
	net-libs/webkit-gtk:4.1
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
"

RDEPEND="${DEPEND}"

src_unpack() {
  default
  tar xf "${FILESDIR}/cargo-${PV}.tar.zst" || die
  unpack "${FILESDIR}/pnpm-store-${PV}.tar.xz"
  unpack "mecab-ipadic-${MECAB_IPADIC_VER}.tar.gz"
}

src_prepare() {
  mkdir -p "${ECARGO_VENDOR}" || die
  rm -rf "${ECARGO_VENDOR}" || die
  ln -s "${WORKDIR}/vendor" "${ECARGO_VENDOR}" || die

  local build_rs="${WORKDIR}/vendor/lindera-ipadic/build.rs"

  # Replace Lindera's build-time HTTP download with a local archive copy.
  sed -i \
    -e '/use std::fs::{create_dir, rename, File};/s/create_dir, rename, File/create_dir, copy, File/' \
    -e '/let tmp_path = Path::new(&build_dir)/,/rename(tmp_path, &source_path_for_build).expect("Failed to rename temporary file");/c\
            let source_path = env::var_os("LINDERA_IPADIC_TARBALL")\
                .ok_or("LINDERA_IPADIC_TARBALL must point to the IPADIC source archive")?;\
            copy(source_path, \&source_path_for_build)?;' \
    "${build_rs}" || die "Failed to patch lindera-ipadic build.rs"

  local crate_dir="${WORKDIR}/vendor/lindera-ipadic"
  local checksum_file="${crate_dir}/.cargo-checksum.json"
  local build_hash

  build_hash=$(sha256sum "${build_rs}") || die
  build_hash=${build_hash%% *}

  grep -q '"build.rs"' "${checksum_file}" ||
    die "build.rs checksum entry not found in ${checksum_file}"

  sed -i -E \
    "s/(\"build.rs\":\"?)[0-9a-f]{64}/\1${build_hash}/" \
    "${checksum_file}" || die "Failed to update vendored checksum"

  default
}

src_configure() {
  cargo_gen_config
}

src_compile() {
  local cargo_opts=(
    --release
    --offline
    --locked
    --features tauri/custom-protocol
    --manifest-path "${S}/src-tauri/Cargo.toml"
  )

  export LINDERA_IPADIC_TARBALL="${DISTDIR}/mecab-ipadic-${MECAB_IPADIC_VER}.tar.gz"
  export RUSTY_V8_ARCHIVE="${DISTDIR}/librusty_v8_release_x86_64-unknown-linux-gnu-v${LIBRUSTY_VER}.a.gz"

  cd "${S}/ui" || die
  XDG_CACHE_HOME="${WORKDIR}/pnpm-cache" \
    pnpm install --offline --frozen-lockfile --trust-lockfile \
    --store-dir "${WORKDIR}/pnpm-store" || die
  pnpm build || die

  cd "${S}" || die
  cargo_env cargo build "${cargo_opts[@]}" || die
}

src_install() {
  dobin "${S}/target/release/limusic-app"

  insinto /usr/share/applications
  doins "${FILESDIR}/limusic.desktop"

  insinto /usr/share/icons/hicolor/128x128/apps/
  newins "${S}/src-tauri/icons/icon.ico" limusic.ico
}
