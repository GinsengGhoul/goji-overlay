EAPI=8

DESCRIPTION=" Powerfull download accelerator and video downloader"
HOMEPAGE="https://xtremedownloadmanager.com/"

SRC_URI="https://github.com/subhra74/xdm/archive/refs/tags/${PV}.zip
         https://raw.githubusercontent.com/subhra74/xdm/refs/heads/old-master-xdm-7.2.11/app/XDM/xdm-logo.svg"

S="${WORKDIR}/${P}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

RDEPEND="virtual/jdk
         net-misc/yt-dlp
         x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip
         sys-apps/coreutils
         dev-java/maven-bin"

SRC_DIR="${S}/app"
maven_repo="${S}/mvn"
#pkg_setup(){}

src_unpack(){
  cat << 'EOF' > "xdman.sh"
#!/bin/sh

# Check if the script is being run as root
if [ "$(id -u)" -eq 0 ]; then
  echo "It's not recommended to run XDM as root, as it can cause problems"
fi

# Source the configuration file if it exists
if [ -f "$HOME/.xdmanrc" ]; then
  . "$HOME/.xdmanrc"
fi

# Run the Java application
exec java -Dsun.java2d.xrender=false -jar /opt/xdman/xdman.jar "$@"
EOF
  chmod +x xdman.sh
  cat << 'EOF' > "youtube-dl"
#!/bin/sh
yt-dlp --compat-options youtube-dl "${@}"
EOF
  chmod +x youtube-dl
  cat << 'EOF' > "xdman.desktop"
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
Exec=xdman
Name=Xtreme Download Manager
Comment=Powerful download accelerator and video downloader
Categories=Network;
Icon=xdman
EOF

  cp ${DISTDIR}/xdm-icon.ico ${WORKDIR}

  cd ${WORKDIR}
  unzip "${DISTDIR}/${PV}.zip"
  mv xdm-${PV} ${S}

  tar -xvf ${FILESDIR}/mvn.tar.xz -C ${S}
}

src_prepare(){
  default
  cd ${SRC_DIR}
  sed -i '/<classifier><\/classifier>/d' pom.xml
}
#src_configure(){}
src_compile(){
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
  doins "${DISTDIR}/xdm-logo.svg"
  
  exeinto /opt/xdman
  doexe "${WORKDIR}/xdman.sh"
  doexe "${WORKDIR}/youtube-dl"

  dosym /opt/xdman/xdman.sh /usr/bin/xdman
  dosym /usr/bin/ffmpeg /opt/xdman/ffmpeg
  dosym /opt/xdman/xdman-logo.svg /usr/share/icons/hicolor/scalable/apps/xdman.svg
}
