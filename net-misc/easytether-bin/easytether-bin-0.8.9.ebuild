# ebuild for easytether-bin
EAPI=8
DESCRIPTION="Internet access via smartphone"
HOMEPAGE="http://www.mobile-stream.com/easytether/drivers.html"


P="easytether"
PV="0.8.9-1"
PFORMAT="pkg.tar.xz"
# i686 x86_64 arm armv6h armv7h aarch64
#ARCH="x86_64"
#SRC_URI="http://www.mobile-stream.com/beta/arch/${P}-${PV}-${ARCH}.${PFORMAT}"
SRC_BASE_URI="http://www.mobile-stream.com/beta/arch"
SRC_URI="\
amd64? ( ${SRC_BASE_URI}/${P}-${PV}-x86_64.${PFORMAT} -> ${P}_x86_64-${PV}.${PFORMAT} ) \
x86? ( ${SRC_BASE_URI}/${P}-${PV}-i686.${PFORMAT} -> ${P}_i686-${PV}.${PFORMAT} ) \
arm? ( ${SRC_BASE_URI}/${P}-${PV}-arm.${PFORMAT} -> ${P}_arm-${PV}.${PFORMAT} ) \
arm64? ( ${SRC_BASE_URI}/${P}-${PV}-aarch64.${PFORMAT} -> ${P}_aarch64-${PV}.${PFORMAT} )"

LICENSE="unknown:freeware"
KEYWORDS="x86 amd64 arm arm64"
SLOT="0"
IUSE="bluetooth systemd"

DEPEND="
        sys-libs/glibc
        dev-libs/openssl-compat
        dev-libs/libusb
        bluetooth? ( net-wireless/bluez )
        !systemd? ( sys-apps/systemd-utils )
        "
RDEPEND="${DEPEND}"
BDEPEND=""
RESTRICT="strip"


S=${WORKDIR}

src_unpack() {
  # Extract the package
  bsdtar -xf "${DISTDIR}/${A}"

  # rename
  mv etc/NetworkManager/system-connections/tap-easytether etc/NetworkManager/system-connections/tap-easytether.nmconnection

  #make udev rule nonsystemd
  echo "ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_interface", ENV{INTERFACE}=="255/66/1", RUN+="/usr/bin/easytether-usb -n %S%p"" > usr/lib/udev/rules.d/99-easytether-usb.rules
}

pkg_preinst() {
    if ! getent passwd _easytether &>/dev/null; then
        useradd -r -c "easytether" -d / -M -s /usr/bin/nologin -U _easytether
    fi
}

src_install() {
    # Install configuration files
    dodir "etc/NetworkManager/system-connections"
    dodir "usr/lib/udev/rules.d"
    keepdir "/etc/easytether"
    keepdir "/var/empty"

    # Install binaries
    if use bluetooth; then
      dobin "usr/bin/easytether-bluetooth"
    fi
    dobin "usr/bin/easytether-local"
    dobin "usr/bin/easytether-usb"

    # install files
    insinto "etc/NetworkManager/system-connections"
    doins "etc/NetworkManager/system-connections/tap-easytether.nmconnection"

    insinto "usr/lib/udev/rules.d"
    doins "usr/lib/udev/rules.d/99-easytether-usb.rules"



    # Create empty directory
    keepdir var/empty
}

pkg_postinst() {
    udevadm control --reload-rules
    udevadm trigger
    elog "easytether-bin has been installed."
    elog "Please ensure that you have the necessary permissions to use it."
}

