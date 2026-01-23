EAPI=8

DESCRIPTION="Linux utility that allows you to use the Super key both to open the start menu and as a modifier key in keyboard shortcuts"
HOMEPAGE="https://github.com/hanschen/ksuperkey"

SRC_URI="https://github.com/hanschen/ksuperkey/archive/refs/heads/master.zip -> ${P}.zip"

S="${WORKDIR}/${PN}-master"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="x11-libs/libX11
         x11-libs/libXtst
         "
DEPEND="${RDEPEND}"
BDEPEND=""

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
