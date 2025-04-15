EAPI=8

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://foo.example.org/"

EGIT_REPO_URI="https://gitlab.archlinux.org/archlinux/arch-install-scripts.git"
inherit git-r3

S="${WORKDIR}/${P}"
LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

src_compile(){
	cd ${S}
	make
}

src_install(){
	cd ${S}
	dobin arch-chroot
	dobin genfstab
	dobin pacstrap
	dodoc doc/arch-chroot.8
	dodoc doc/genfstab.8
	dodoc doc/pacstrap.8
}
