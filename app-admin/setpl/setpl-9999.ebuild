EAPI=8

DESCRIPTION="Linux script for setting the PL1/PL2 power limits on modern Intel processors"
HOMEPAGE="https://github.com/horshack-dpreview/setPL"

SRC_URI="https://raw.githubusercontent.com/horshack-dpreview/setPL/refs/heads/master/setPL.sh"

S="${WORKDIR}/${P}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-apps/devmem2
		 sys-apps/msr-tools"
DEPEND="${RDEPEND}"
BDEPEND=""

src_unpack(){
	mkdir -p ${S}
}

src_compile(){
	cp ${S}/../../distdir/setPL.sh ${S}/setPL
}

src_install(){
	cd ${S}
	dobin setPL
}
