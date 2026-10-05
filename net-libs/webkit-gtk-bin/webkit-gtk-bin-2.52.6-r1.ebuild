EAPI=9

DESCRIPTION="WebKitGTK browser engine grabbed from Arch Linux (Non-systemd / Systemd adjustable)"
HOMEPAGE="https://webkitgtk.org/"

MY_PKGREL="1"
MY_P="webkitgtk-6.0-${PV}-${MY_PKGREL}"
SRC_URI="https://geo.mirror.pkgbuild.com/extra/os/x86_64/${MY_P}-x86_64.pkg.tar.zst -> ${P}.tar.zst"

LICENSE="LGPL-2+ BSD"
SLOT="6/0"
KEYWORDS="amd64"
IUSE="systemd"
RESTRICT="strip"

BDEPEND="app-arch/zstd"
S="${WORKDIR}"

COMMON_DEPEND="
    app-accessibility/at-spi2-core
    app-crypt/libsecret
    app-misc/geoclue
    app-text/enchant
    dev-db/sqlite
    dev-libs/expat
    dev-libs/glib
    dev-libs/hyphen
    dev-libs/icu
    dev-libs/libgcrypt
    dev-libs/libmanette
    dev-libs/libtasn1
    dev-libs/libxml2
    dev-libs/libxslt
    dev-libs/wayland
    media-fonts/noto
    media-libs/fontconfig
    media-libs/freetype
    media-libs/gst-plugins-bad
    media-libs/gst-plugins-base
    media-libs/gstreamer
    media-libs/harfbuzz
    media-libs/lcms
    media-libs/libavif
    media-libs/libepoxy
    media-libs/libglvnd
    media-libs/libjpeg-turbo
    media-libs/libjxl
    media-libs/libpng
    media-libs/libwebp
    media-libs/mesa
    media-libs/openjpeg
    x11-libs/pango
    media-libs/woff2
    net-libs/libsoup:3.0
    sys-apps/bubblewrap
    sys-apps/xdg-dbus-proxy
    sys-libs/glibc
    sys-libs/libseccomp
    sys-libs/zlib
    x11-libs/cairo
    x11-libs/gdk-pixbuf
    x11-libs/libX11
    x11-libs/libdrm
    systemd? ( sys-libs/systemd )
"

RDEPEND="!net-libs/webkit-gtk:6
         ${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

src_unpack() {
  mkdir -p "${S}"
  tar xpf "${DISTDIR}/${P}.tar.zst" -C "${S}"
}

src_install() {
  if [[ -d "${S}/usr" ]]; then
    mkdir -p "${D}/usr" || die
    cp -R "${S}/usr/." "${D}/usr/" || die
  fi

  local libdir="$(get_libdir)"
  if [[ ${libdir} != "lib" ]] && [[ -d "${D}/usr/lib" ]]; then
    mkdir -p "${D}/usr/${libdir}" || die
    mv "${D}/usr/lib/"* "${D}/usr/${libdir}/" || die
    rm -rf "${D}/usr/lib"
  fi

  if [[ -d "${D}/usr/${libdir}/pkgconfig" ]]; then
    for pc in "${D}/usr/${libdir}/pkgconfig"/*.pc; do
      if [[ -f ${pc} ]]; then
        sed -i -e "s|/usr/lib|/usr/${libdir}|g" "${pc}" || die
      fi
    done
  fi
}
