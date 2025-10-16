EAPI=8
inherit cmake

DESCRIPTION="Marking up images for use with Darknet."
HOMEPAGE="https://www.ccoderun.ca/darkmark/Summary.html"
mPN="DarkMark"
COMMIT="70f7b5dc74b2eef0a9dfc6a2f5500d9b38b59ffb"
SRC_URI="https://github.com/stephanecharette/${mPN}/archive/${COMMIT}.zip -> ${P}.zip"
#EGIT_REPO_URI="https://github.com/SUSE/cpuset.git"
#inherit git-r3

S="${WORKDIR}/${mPN}-${COMMIT}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="media-libs/opencv
         x11-libs/libX11
         media-libs/freetype
         x11-libs/libXrandr
         x11-libs/libXinerama
         x11-libs/libXcursor
         dev-perl/File-LibMagic
         app-text/poppler"
DEPEND="${RDEPEND}"
BDEPEND=""

#pkg_setup(){}
src_unpack(){
  default
}
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
