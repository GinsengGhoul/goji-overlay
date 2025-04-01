EAPI=8

DESCRIPTION="Vim totally installed"
HOMEPAGE="https://www.vim.org"
SRC_URI="https://raw.githubusercontent.com/vim/vim/master/src/xxd/xxd.c
          https://raw.githubusercontent.com/vim/vim/master/runtime/doc/xxd.1
          https://raw.githubusercontent.com/vim/vim/master/src/xxd/Makefile
          https://raw.githubusercontent.com/vim/vim/master/LICENSE"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="app-editors/neovim"
DEPEND="${RDEPEND}"
BDEPEND=""
PROVIDE="dev-util/xxd"

src_unpack() {
	mkdir -p "${S}"
	cp "${DISTDIR}"/* "${S}"
}

src_compile() {
	cd ${S}
	emake -f "Makefile"
}

src_install() {
	cd ${S}
	dodir /usr/bin
    dobin xxd
    dodoc LICENSE
    insinto /usr/share/man/man1
    newins xxd.1 xxd.1

    # Create the symlink after ensuring the target exists
    if [[ -e "${D}/usr/bin/nvim" ]]; then
        ln -s /usr/bin/nvim "${D}/usr/bin/vim"
    else
        einfo "Warning: nvim not found, skipping symlink creation for vim."
    fi
}

pkg_postinst() {
    elog "VTI has been installed. You can use 'vim' and 'vi' as aliases for 'nvim'."
}

