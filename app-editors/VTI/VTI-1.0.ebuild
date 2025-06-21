EAPI=8

DESCRIPTION="Vim totally installed"
HOMEPAGE="https://www.vim.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="network-sandbox"

RDEPEND="app-editors/neovim"
DEPEND="${RDEPEND}"
BDEPEND="net-misc/curl"
PROVIDE="dev-util/xxd"

src_unpack() {
	mkdir -p "${S}"
	cd ${S}
	curl -O "https://raw.githubusercontent.com/vim/vim/master/src/xxd/xxd.c"
	curl -O "https://raw.githubusercontent.com/vim/vim/master/runtime/doc/xxd.1"
	curl -O "https://raw.githubusercontent.com/vim/vim/master/src/xxd/Makefile"
	curl -O "https://raw.githubusercontent.com/vim/vim/master/LICENSE"
}

src_compile() {
	cd ${S}
	emake -f "Makefile"
}

src_install() {
	dodir /usr/bin
	ln -s nvim "${D}/usr/bin/vim"

	cd ${S}
	dobin xxd
	dodoc LICENSE
	insinto /usr/share/man/man1
	newins xxd.1 xxd.1
}

pkg_postinst() {
	elog "VTI has been installed. You can use 'vim' and 'vi' as aliases for 'nvim'."
}

