EAPI=8

DESCRIPTION="installs the dependencies to run winapps"
HOMEPAGE="https://github.com/winapps-org/winapps"

#SRC_URI="ftp://foo.example.org/${P}.tar.gz -> ${P}.tar.gz"
#EGIT_REPO_URI="https://github.com/SUSE/cpuset.git"
#inherit git-r3

#S="${WORKDIR}/${P}"
LICENSE="GPL3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND=" net-misc/curl
          dev-util/dialog
          net-misc/freerdp:3
          dev-vcs/git
          sys-apps/iproute2
          x11-libs/libnotify
          net-analyzer/openbsd-netcat
          "
DEPEND="${RDEPEND}"
BDEPEND=""

#pkg_setup(){}
#src_unpack(){}
#src_prepare(){}
#src_configure(){}
#src_compile(){}
#src_install(){}
