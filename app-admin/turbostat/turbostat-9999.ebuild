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
BDEPEND="dev-vcs/git"

S="${WORKDIR}/linux/tools/power/x86/turbostat"
inherit toolchain-funcs

pkg_setup() {
  cd /tmp
  git clone -n --depth=1 --filter=tree:0 https://github.com/torvalds/linux.git
  cd linux
  git sparse-checkout init
  git sparse-checkout set tools/power/x86/turbostat tools/include arch/x86/include/asm include/linux
  git checkout
  cd /tmp
  tar -czf turbostat-src.tar.gz linux
}

src_unpack() {
  cp /tmp/turbostat-src.tar.gz ${WORKDIR}
  cd ${WORKDIR}
  tar xzf turbostat-src.tar.gz
}

src_compile() {
  cd ${S}
  sed -i "s/-O2 -Wall -Wextra/${CFLAGS}/" Makefile
  emake turbostat
}

src_install() {
  cd ${S}
  dobin turbostat
  dodoc turbostat.8
}

pkg_postinst() {
  rm -rf /tmp/linux
  rm /tmp/turbostat-src.tar.gz
}
