EAPI=8

DESCRIPTION="On-screen keyboard for wlroots"
HOMEPAGE="https://github.com/jjsullivan5196/wvkbd"

SRC_URI="https://github.com/jjsullivan5196/${PN}/archive/refs/tags/v${PV}.tar.gz"

#S="${WORKDIR}/${P}"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="x11-libs/cairo
         x11-libs/pango
         x11-libs/libxkbcommon"
DEPEND="${RDEPEND}"
BDEPEND=""

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
#src_configure(){}
src_compile() {
  default_src_compile
  sed -i "s/VERSION/${PV}/g" ${PN}.1
}
src_install() {
  dobin ${PN}-mobintl
  doman ${PN}.1
}
