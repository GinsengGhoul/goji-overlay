# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# adapated from AUR package https://aur.archlinux.org/packages/foo2zjs-nightly

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="("http://foo2zjs.rkkda.com/"

LICENSE="GPL-2"
SLOT="0"
PROPERTIES="live"
IUSE="test"

RESTRICT="bindist !test? ( test )"

RDEPEND="net-print/cups
	net-print/foomatic-db-engine
	>=net-print/cups-filters-1.0.43-r1[foomatic]
	virtual/udev"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip
	app-editors/vim
	net-misc/wget
	sys-apps/ed
	app-alternatives/bc
	test? ( sys-process/time )"

S="${WORKDIR}/${PN}"

SRC_URI="http://foo2zjs.linkevich.net/foo2zjs/${PN}.tar.gz"
        okic301     ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic301.tar.gz")
        okic310     ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic310.tar.gz")
        okic3200    ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic3200.tar.gz")
        okic3400    ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic3400.tar.gz")
        okic511     ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic511.tar.gz")
        okic5600    ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic5600.tar.gz")
        okic810     ? ("http://foo2zjs.linkevich.net/foo2hiperc/icm/okic810.tar.gz")
        hp1215      ? ("http://foo2zjs.linkevich.net/foo2hp/icm/hp1215.tar.gz")
        hpclj2500   ? ("http://foo2zjs.linkevich.net/foo2hp/icm/hpclj2500.tar.gz")
        hpclj2600n  ? ("http://foo2zjs.linkevich.net/foo2hp/icm/hpclj2600n.tar.gz")
        km-1600     ? ("http://foo2zjs.linkevich.net/foo2lava/icm/km-1600.tar.gz")
        km2530      ? ("http://foo2zjs.linkevich.net/foo2lava/icm/km2530.tar.gz")
        samclp300   ? ("http://foo2zjs.linkevich.net/foo2qpdl/icm/samclp300.tar.gz")
        samlp315    ? ("http://foo2zjs.linkevich.net/foo2qpdl/icm/samclp315.tar.gz")
        lexc500     ? ("http://foo2zjs.linkevich.net/foo2slx/icm/lexc500.tar.gz")
        sihp1000    ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihp1000.tar.gz")
        sihp1005    ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihp1005.tar.gz")
        sihp1018    ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihp1018.tar.gz")
        sihp1020    ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihp1020.tar.gz")
        sihpP1005   ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihpP1005.tar.gz")
        sihpP1006   ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihpP1006.tar.gz")
        sihpP1505   ? ("http://foo2zjs.linkevich.net/foo2zjs/firmware/sihpP1505.tar.gz")
        dl2300      ? ("http://foo2zjs.linkevich.net/foo2zjs/icm/dl2300.tar.gz")
        hp-cp1025   ? ("http://foo2zjs.linkevich.net/foo2zjs/icm/hp-cp1025.tar.gz")
        km2430      ? ("http://foo2zjs.linkevich.net/foo2zjs/icm/km2430.tar.gz")
"

src_unpack() {
  tar xpvf ${DISTDIR}/${PN}.tar.gz ${WORKDIR}
}

src_prepare() {
}

src_compile() {
	MAKEOPTS=-j1 CC="$(tc-getCC)" default
}

src_test() {
}

src_install() {
}
