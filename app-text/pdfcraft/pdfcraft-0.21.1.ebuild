EAPI=8

inherit cargo
DESCRIPTION="An open-source PDF reader and editor written from scratch in pure Rust"
HOMEPAGE="https://getartcraft.com/apps/pdfcraft"

SRC_URI="https://github.com/storytold/pdfcraft/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
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
  tar xf "${FILESDIR}/cargo-${PV}.tar.zst" -C ${WORKDIR} || die
}
#src_prepare(){}
src_configure(){
	default
	cargo_gen_config
  rm -r vendor
  mv ${WORKDIR}/vendor .
}
#src_compile(){}
#src_test(){}
src_install() {
	dobin target/release/pdfcraft
	dobin target/release/pdfcraft-cli

    insinto /usr/share/applications
    doins packaging/linux/ai.storyteller.pdfcraft.desktop

    insinto /usr/share/mime/packages
    doins packaging/linux/ai.storyteller.pdfcraft.mime.xml

    insinto /usr/share/icons
    doins -r assets/app-icon/hicolor
}
#pkg_preinst(){}
#pkg_postinst(){}
