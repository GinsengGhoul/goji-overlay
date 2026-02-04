EAPI=8
inherit meson

DESCRIPTION="GPU-accelerated live wallpaper engine for Linux using GLSL shaders. Runs on Wayland and X11."
HOMEPAGE="https://github.com/1ay1/neowall.git"

SRC_URI="https://github.com/1ay1/neowall/releases/download/v${PV}/${P}-source.tar.gz"

S="${WORKDIR}/${P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="wayland X"
RESTRICT="strip"

RDEPEND="media-libs/libpng
         media-libs/libjpeg-turbo
         wayland? ( dev-libs/wayland
                   dev-libs/wayland-protocols )
         X? ( x11-libs/libX11
              x11-libs/libXrandr )"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/meson
         app-alternatives/ninja"

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
src_configure() {
        local emesonargs=(
                $(meson_feature wayland wayland_backend)
                $(meson_feature X x11_backend)
        )
        meson_src_configure
}
#src_compile(){}
#src_install(){}
