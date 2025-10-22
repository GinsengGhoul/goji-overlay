EAPI=8

DESCRIPTION=" C++ wrapper library for Darknet "
HOMEPAGE="https://www.ccoderun.ca/darkhelp/api/Summary.html"
SRC_URI=""

S="${WORKDIR}/${P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="march"

RDEPEND="app-misc/darknet
         dev-cpp/tclap
         sys-apps/file
         media-libs/opencv"
DEPEND="${RDEPEND}"
BDEPEND=""

pkg_setup(){
  cd "${T}"
  git clone "https://github.com/stephanecharette/DarkHelp.git" ${P}
  tar cf "${P}.tar" "${P}"
  mv "${P}.tar" "${WORKDIR}"
}

src_unpack(){
  cd "${WORKDIR}"
  tar xf "${P}.tar"
}
#src_prepare(){}
src_configure(){
  unused="-Wno-error=unused-function -Wno-error=unused-const-variable"
  CFLAGS="${CFLAGS} ${unused}"
  CXXFLAGS="${CXXFLAGS} ${unused}"
  cd "${S}"
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${D}/usr" -B build .
  sed -i "s|#include <thread>|#include <thread>\n#include <deque>|" src-lib/DarkHelpThreads.hpp
}
src_compile(){
  cd "${S}/build"
  cmake --build . --parallel $(nproc)
}
src_install(){
  cd "${S}/build"
  cmake --install .
  mkdir -p "${D}/$(get_libdir)"
  mv ${D}/usr/lib/*.so* "${D}/$(get_libdir)"
}
