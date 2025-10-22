EAPI=8

DESCRIPTION="Marking up images for use with Darknet."
HOMEPAGE="https://www.ccoderun.ca/darkmark/Summary.html"
SRC_URI=""

S="${WORKDIR}/${P}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="march"

RDEPEND="app-misc/darknet
         dev-cpp/darkhelp
         media-libs/freetype
         x11-libs/libX11
         x11-libs/libXinerama
         x11-libs/libXrandr
         x11-libs/libXcursor
         sys-apps/file
         app-text/poppler
         media-libs/opencv"
DEPEND="${RDEPEND}"
BDEPEND=""

pkg_setup(){
  cd "${T}"
  git clone "https://github.com/stephanecharette/DarkMark.git" ${P}
  tar cf "${P}.tar" "${P}"
  mv "${P}.tar" "${WORKDIR}"
}

src_unpack(){
  cd "${WORKDIR}"
  tar xf "${P}.tar"
}
#src_prepare(){}
src_configure(){
  flags="-Wno-error=inconsistent-missing-override -Wno-error=deprecated-literal-operator -Wno-error=main"
  CFLAGS="${CFLAGS} ${flags}"
  CXXFLAGS="${CXXFLAGS} ${flags}"
  cd "${S}"
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${D}/usr" -B build .
}
src_compile(){
  cd "${S}/build"
  cmake --build . --parallel $(nproc)
}
src_install(){
  cd "${S}/build"
  sed -i "s|/usr/share|${D}/usr/share|g" src-ubuntu/cmake_install.cmake
  cmake --install .
  mkdir -p "${D}/$(get_libdir)"
  #mv ${D}/usr/lib/*.so* "${D}/$(get_libdir)"
}
