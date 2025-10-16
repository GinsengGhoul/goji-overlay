EAPI=8
inherit cmake

DESCRIPTION="Darknet/YOLO object detection framework"
HOMEPAGE="https://darknetcv.ai/"
COMMIT="b992aebeb57aeb7dd3edab970dad4c93d65a0dac"
SRC_URI="https://github.com/hank-ai/${PN}/archive/v${PV}.zip -> ${P}.zip
         ${FILESDIR/${P}.tar}"

S="${WORKDIR}/${P}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="sci-libs/openblas
         media-libs/opencv"
DEPEND="${RDEPEND}"
BDEPEND=""

CMAKE_BUILD_TYPE="Release"

#pkg_setup(){}
src_unpack(){
  default_src_unpack
  cd ${S}
  tar xvf ${DISTDIR}/${P}.tar
  }
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
