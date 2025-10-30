EAPI=8
CRATES=" "
inherit cargo

DESCRIPTION="A tool to unzip an archive in parallel"
HOMEPAGE="https://github.com/gentoo/cargo-ebuild"
SRC_URI="https://github.com/GoogleChrome/ripunzip/archive/refs/tags/v2.0.3.zip -> ${P}.zip
         https://github.com/GinsengGhoul/goji-overlay/raw/refs/heads/master/app-arch/ripunzip/vendor-${PV}.tar.xz"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD LGPL-3+ MIT Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="x86 amd64"

src_prepare() {
  rm -r "${ECARGO_VENDOR}"
  ln -s "${WORKDIR}/vendor" "${ECARGO_VENDOR}"
  default_src_prepare
}
