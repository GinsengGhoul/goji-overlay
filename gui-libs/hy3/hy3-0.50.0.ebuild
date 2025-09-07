EAPI=8
inherit cmake

DESCRIPTION="Hyprland plugin for an i3 / sway like manual tiling layout"
HOMEPAGE="https://github.com/outfoxxed/hy3/"

SRC_URI="https://github.com/outfoxxed/${PN}/archive/refs/tags/hl${PV}.zip"

S="${WORKDIR}/${PN}-hl${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

MY_PV="${PV/.0/}"
RDEPEND=">=gui-wm/hyprland-${PV} <gui-wm/hyprland-${MY_PV}.99"
DEPEND="dev-build/cmake
        ${RDEPEND}"
BDEPEND=""
HYPRLIBS="/usr/lib/hyprland"

src_configure() {
  cmake_src_configure
}

src_compile() {
  cmake_src_compile
}

src_install() {
  dodir ${HYPRLIBS}
  into ${HYPRLIBS}
  dolib.so $BUILD_DIR/libhy3.so
}
