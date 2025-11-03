EAPI=8

DESCRIPTION="A key remapping daemon for linux"
HOMEPAGE="https://github.com/rvaiya/keyd"
SRC_URI=""
EGIT_REPO_URI="https://github.com/rvaiya/${PN}.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
inherit git-r3

RDEPEND="acct-group/keyd"
DEPEND="${RDEPEND}"
