EAPI=8

DESCRIPTION="Darknet/YOLO object detection framework"
HOMEPAGE="https://darknetcv.ai/"
SRC_URI=""

S="${WORKDIR}/${P}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="cpuonly march"

RDEPEND="cpuonly? ( sci-libs/openblas )
         media-libs/opencv"
DEPEND="${RDEPEND}"
BDEPEND=""

CMAKE_BUILD_TYPE="Release"

pkg_setup(){
  cd "${T}"
  git clone "https://github.com/hank-ai/darknet.git" ${P}
  tar cf "${P}.tar" "${P}"
  mv "${P}.tar" "${WORKDIR}"
}

src_unpack(){
  cd "${WORKDIR}"
  tar xf "${P}.tar"
}
#src_prepare(){}
src_configure(){
  cd "${S}"
  CC="gcc"
  CXX="g++"
  CPP="gcc -E"
  AR="ar"
  NM="nm"
  RANLIB="ranlib"

  if use march; then
    CFLAGS=$( gcc -### -E - -march=native 2>&1 | sed -r '/cc1/!d;s/(")|(^.* - )//g;s/ -dumpbase -//' | sed 's/ -fcf-protection.*//' )
  else
    CFLAGS="-march=x86-64 -mtune=generic"
  fi

  CFLAGS="${CFLAGS} -fno-plt -fno-semantic-interposition -fno-trapping-math -fopenmp -pipe"
  CXXFLAGS="${CFLAGS}"
  LDFLAGS="-Wl,-O2 -Wl,--sort-common -Wl,--as-needed -Wl,-z,pack-relative-relocs"
  ewarn "default compiler is switched to GCC as darknet uses optimizations not avalible on clang"
  einfo "CFLAGS=${CFLAGS}"
  einfo "CXXFLAGS=${CXXFLAGS}"
  einfo "LDFLAGS=${LDFLAGS}"
  
  sed -i 's|\${OpenBLAS_INCLUDE_DIRS}|/usr/include/openblas|g' CM_dependencies.cmake
  sed -i 's|\${OpenBLAS_LIBRARIES}|/usr/lib64/libopenblas.so|g' CM_dependencies.cmake
  cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${D}/usr" -B build .
}
src_compile(){
  cd "${S}/build"
  cmake --build . --parallel $(nproc)
}
src_install(){
  cd "${S}/build"
  sed -i "s/\/opt\/darknet\/cfg/$(echo ${D} | sed "s/\//\\\\\//g")\/opt\/darknet\/cfg/g" ${S}/build/cfg/cmake_install.cmake
  cmake --install .
  mkdir -p "${D}/$(get_libdir)"
  mv ${D}/usr/lib/*.so* "${D}/$(get_libdir)"
}
