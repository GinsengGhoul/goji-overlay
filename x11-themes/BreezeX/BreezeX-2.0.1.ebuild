EAPI=8

DESCRIPTION="Extended KDE cursor, Highly inspired on KDE Breeze for Windows and Linux with HiDPi Support."
HOMEPAGE="https://github.com/ful1e5/BreezeX_Cursor"

SRC_URI="https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${PV}/${PN}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}"
#src_prepare(){}

src_install(){
	cd "${S}"
	insinto /usr/share/icons/
    doins -r BreezeX-Black
    doins -r BreezeX-Dark
    doins -r BreezeX-Light
}
