# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit go-module

DESCRIPTION="A shell parser, formatter, and interpreter with bash support"
HOMEPAGE="https://github.com/mvdan/sh"

SRC_URI="https://github.com/mvdan/sh/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# The path within the repository where the main package for shfmt is located
EGO_PN="mvdan.cc/sh/v3/cmd/shfmt"
S="${WORKDIR}/sh-${PV}"

src_unpack() {
  default
  tar xvf ${FILESDIR}/${P}-vendor.tar.xz -C "${S}"
}

src_compile() {
  ego build -mod=vendor -o shfmt ./cmd/shfmt
}

src_install() {
  dobin shfmt
  dodoc README.md
}
