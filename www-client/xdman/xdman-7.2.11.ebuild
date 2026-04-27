EAPI=8

DESCRIPTION=" Powerfull download accelerator and video downloader"
HOMEPAGE="https://xtremedownloadmanager.com/"

SRC_URI="https://github.com/subhra74/xdm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
         https://raw.githubusercontent.com/subhra74/xdm/refs/heads/old-master-xdm-7.2.11/app/XDM/xdm-logo.svg
         https://raw.githubusercontent.com/subhra74/xdm/refs/heads/old-master-xdm-7.2.11/app/XDM/xdm-logo.ico"

#S="${WORKDIR}/${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/jdk
         net-misc/yt-dlp
         x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}"
BDEPEND="sys-apps/coreutils
         dev-java/maven-bin:3.9"

SRC_DIR="${S}/app"
maven_repo="${S}/mvn"

src_unpack() {
  default
  mv "${WORKDIR}/xdm-${PV}" "${S}"

  cp "${DISTDIR}/xdm-logo."{ico,svg} "${WORKDIR}/"

  cp "${FILESDIR}/"{xdman.desktop,xdman.sh,youtube-dl} "${WORKDIR}/"

  cd "${WORKDIR}"
  mv "xdm-${PV}" "${S}"

  # local maven_repo made with this
  # mvn dependency:go-offline -Dmaven.repo.local=/tmp/mvn
  tar -xvf "${FILESDIR}/mvn.tar.xz" -C "${S}"
}

src_prepare() {
  default
  cd ${SRC_DIR}
  sed -i '/<classifier><\/classifier>/d' pom.xml
}

src_compile() {
  cd ${SRC_DIR}
  mvn -Dmaven.repo.local="${maven_repo}" -e clean
  mvn -Dmaven.repo.local="${maven_repo}" -e package --offline
}

src_install() {
  insinto /usr/share/applications
  doins "${WORKDIR}/xdman.desktop"

  dodir /opt/xdman

  insinto /opt/xdman
  doins "${SRC_DIR}/target/xdman.jar"
  doins "${WORKDIR}/xdm-logo.svg"
  doins "${WORKDIR}/xdm-logo.ico"

  exeinto /opt/xdman
  doexe "${WORKDIR}/xdman.sh"
  doexe "${WORKDIR}/youtube-dl"

  dosym /opt/xdman/xdman.sh /usr/bin/xdman
  dosym /usr/bin/ffmpeg /opt/xdman/ffmpeg
  dosym /opt/xdman/xdman-logo.svg /usr/share/icons/hicolor/scalable/apps/xdman.svg
  dosym /opt/xdman/xdman-logo.ico /usr/share/icons/hicolor/256x256/apps/xdman.ico
}
