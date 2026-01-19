EAPI=8

DESCRIPTION="A simple, independent and contemporary-looking X11 menu, designed for scripting, modding and tweaking."
HOMEPAGE="https://github.com/jgmenu/jgmenu"

SRC_URI="https://github.com/jgmenu/jgmenu/archive/refs/tags/v${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="lxde-base/lxmenu-data
         dev-libs/libxml2
         x11-libs/libXrandr
         x11-libs/cairo
         x11-libs/pango
         dev-libs/glib"
DEPEND="${RDEPEND}"
BDEPEND=""

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
