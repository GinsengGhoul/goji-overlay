EAPI=8

inherit cargo
DESCRIPTION="An open-source photo editor written from scratch in pure Rust"
HOMEPAGE="https://getartcraft.com/apps/photocraft"

SRC_URI="https://github.com/storytold/photocraft/archive/refs/tags/v0.23.1.tar.gz -> ${P}.tar.gz"
PATCHES=( "${FILESDIR}/${P}-vendor.patch" )
#S="${WORKDIR}/${P}"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
#RESTRICT="strip"

RDEPEND="
	media-libs/vulkan-loader
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libxcb
	x11-libs/libxkbcommon[X]
	dev-libs/wayland
"
DEPEND="${RDEPEND}"
BDEPEND=""

RUST_MIN_VER="1.95"

#pkg_pretend(){}
#pkg_setup(){}
src_unpack() {
  default
  tar xf "${FILESDIR}/cargo-${PV}.tar.zst" -C ${S} || die
}
#src_prepare(){}
src_configure(){
	default
	cargo_gen_config
}
#src_compile(){}
#src_test(){}
src_install() {
	dobin target/release/photocraft
	dobin target/release/photocraft-cli

    insinto /usr/share/applications
    doins packaging/linux/ai.storyteller.photocraft.desktop

    insinto /usr/share/mime/packages
    doins packaging/linux/ai.storyteller.photocraft.mime.xml

    insinto /usr/share/icons
    doins -r assets/app-icon/hicolor
}
#pkg_preinst(){}
#pkg_postinst(){}
