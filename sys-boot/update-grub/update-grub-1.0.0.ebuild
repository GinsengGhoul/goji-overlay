# ebuild for easytether-bin
EAPI=8
DESCRIPTION="update grub script from ubuntu"
HOMEPAGE="https://packages.ubuntu.com/jammy/admin/grub-common"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
        app-alternatives/sh
        "
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_unpack() {
  cat << 'EOF' > "update-grub"
  #!/bin/sh
set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "$@"
EOF
  chmod +x "update-grub"
}

src_install() {
    dobin "update-grub"
}
