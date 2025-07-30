EAPI=8

DESCRIPTION="Simple program to read/write from/to any location in memory."
HOMEPAGE="http://lartmaker.nl/lartware/port/"

SRC_URI="http://lartmaker.nl/lartware/port/devmem2.c"

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
  if [ -n ${CC} ]; then
    ${CC} -c devmem2.c ${CFLAGS} -fPIC
    ${CC} -o devmem2 devmem2.o ${LDFLAGS}
  else
    cc -c devmem2.c ${CFLAGS} -fPIC
    cc -o devmem2 devmem2.o ${LDFLAGS}
  fi
}

src_install(){
	dobin devmem2
}
