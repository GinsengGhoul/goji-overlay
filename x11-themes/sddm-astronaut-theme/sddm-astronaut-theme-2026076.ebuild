EAPI=8

DESCRIPTION="Series of modern looking themes for SDDM."
HOMEPAGE="https://github.com/Keyitdev/sddm-astronaut-theme"
COMMIT_HASH="292c87b770ff9eab1903dd2c6ddff466faf87fb0"

SRC_URI="https://github.com/Keyitdev/${PN}/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_HASH}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip mirror"

inherit font

RDEPEND="
  >=x11-misc/sddm-0.21.0
  >=dev-qt/qtbase-6.8.0:6=
  >=dev-qt/qtsvg-6.8.0:6=
  >=dev-qt/qtmultimedia-6.8.0:6=
  >=dev-qt/qtvirtualkeyboard-6.8.0:6=
"

DEPEND="${RDEPEND}"
BDEPEND=""

src_install() {
  insinto "/etc/sddm.conf.d/"
  doins "${FILESDIR}/sddm-astronaut-theme.conf"

  insinto "/usr/share/sddm/themes/${PN}"
  doins -r *

  insinto "/usr/share/fonts/astronaut"
  doins -r Fonts/*
}

pkg_postinst() {
  font_pkg_postinst
}

pkg_postrm() {
  font_pkg_postrm
}
