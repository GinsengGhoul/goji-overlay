EAPI=8

DESCRIPTION="Simple program to read/write from/to any location in memory."
HOMEPAGE="http://lartmaker.nl/lartware/port/"

SRC_URI="http://lartmaker.nl/lartware/port/devmem2.c"
inherit toolchain-funcs

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/"

src_unpack(){
  cp ${S}/../distdir/devmem2.c ${S}
}

src_compile(){
  CC=$(tc-getCC)
  ${CC} ${CFLAGS} ${LDFLAGS} -c devmem2.c ${CFLAGS} -fPIC
  ${CC} ${CFLAGS} ${LDFLAGS} -o devmem2 devmem2.o ${LDFLAGS}
}

src_install(){
  dobin devmem2
}
