# ebuild for easytether-bin
EAPI=8
DESCRIPTION="update grub script from ubuntu"
HOMEPAGE="https://packages.ubuntu.com/jammy/admin/grub-common"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="app-alternatives/sh
        sys-boot/grub"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
  dobin "${FILESDIR}/update-grub"
}
