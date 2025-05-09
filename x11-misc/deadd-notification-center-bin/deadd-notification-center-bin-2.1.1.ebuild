EAPI=8
DESCRIPTION="A haskell-written notification center for users that like a desktop with style…"
HOMEPAGE="https://github.com/phuhl/linux_notification_center"

SRC_URI="https://github.com/phuhl/linux_notification_center/raw/refs/tags/${PV}/docs/linux-notification-center.man
		 https://github.com/phuhl/linux_notification_center/raw/refs/tags/${PV}/LICENSE
		 https://github.com/phuhl/linux_notification_center/releases/download/${PV}/deadd-notification-center"

S="${WORKDIR}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="dev-libs/gobject-introspection
		 x11-libs/gtk+"
DEPEND="${RDEPEND}"
BDEPEND=""

src_unpack() {
	# No unpacking needed since we are using pre-built binaries
	return 0
}

src_install() {
	# Install the binary
	dobin "${DISTDIR}/deadd-notification-center"

	# Install the man page and license
	dodoc "${DISTDIR}/linux-notification-center.man" "${DISTDIR}/LICENSE"
}
