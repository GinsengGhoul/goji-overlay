EAPI=8

DESCRIPTION="The task switcher for minimalistic window managers or standalone X11 session."
HOMEPAGE="https://github.com/sagb/alttab"

SRC_URI="https://github.com/sagb/${PN}/archive/refs/tags/v${PV}.tar.gz"

#S="${WORKDIR}/${P}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="x11-libs/libX11
         x11-libs/libXft
         x11-libs/libXrender
         x11-libs/libXrandr
         media-libs/libpng
         x11-libs/libXpm
         dev-libs/uthash"
DEPEND="${RDEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/0001-Declare-func-void-fix-two-related-errors.patch" )

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
