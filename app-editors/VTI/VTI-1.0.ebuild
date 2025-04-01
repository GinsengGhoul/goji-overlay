EAPI=8

DESCRIPTION="Vim totally installed"
HOMEPAGE="https://www.vim.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="app-editors/neovim
		 dev-util/xxd"
DEPEND="${RDEPEND}"
BDEPEND=""

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    dodir /usr/bin
    ln -s /usr/bin/nvim "${D}/usr/bin/vim"
}

pkg_postinst() {
    elog "VTI has been installed. You can use 'vim' and 'vi' as aliases for 'nvim'."
}

