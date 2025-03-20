EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="a Python application that abstracts standard Linux cpusets"
HOMEPAGE="https://github.com/SUSE/cpuset"

EGIT_REPO_URI="https://github.com/SUSE/cpuset.git"
inherit git-r3

S="${WORKDIR}/${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT=""

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/python"
