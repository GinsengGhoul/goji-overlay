EAPI=8

DESCRIPTION="Vim totally installed"
HOMEPAGE="https://www.vim.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="network-sandbox"

RDEPEND="
         app-editors/neovim
         dev-util/xxd
         "
DEPEND="${RDEPEND}"
BDEPEND="net-misc/curl"

S="${WORKDIR}"

src_install() {
  dodir /usr/bin
	ln -s nvim "${D}/usr/bin/vi"
	ln -s nvim "${D}/usr/bin/vim"
}

pkg_postinst() {
	elog "VTI has been installed. You can use 'vim' and 'vi' as aliases for 'nvim'."
}

