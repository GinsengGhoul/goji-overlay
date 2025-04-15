EAPI=8

DESCRIPTION="idle power-state statistics, temperature and power on X86 processors."
HOMEPAGE="https://github.com/torvalds/linux/tree/master/tools/power/x86/turbostat"

SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/turbostat/tools/power/x86/turbostat"
inherit toolchain-funcs
src_unpack(){
	mkdir -p ${WORKDIR}/turbostat
	cd ${WORKDIR}/turbostat
	mkdir -p tools/power/x86/
	mkdir -p arch/x86/
	mkdir include

	cp -r /usr/src/linux/tools/power/x86/turbostat tools/power/x86
	cp -r /usr/src/linux/tools/include tools
	cp -r /usr/src/linux/arch/x86/include arch/x86
	cp -r /usr/src/linux/include/linux include
}

src_compile() {
	cd ${S}
	emake turbostat
}

src_install(){
	cd ${S}
	dobin turbostat
	dodoc turbostat.8
}
