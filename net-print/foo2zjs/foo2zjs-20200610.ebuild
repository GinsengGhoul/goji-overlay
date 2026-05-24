EAPI=8
inherit toolchain-funcs flag-o-matic
DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"
SLOT="0"
PROPERTIES="live"
IUSE="okic301 okic310 okic3200 okic3400 okic511 okic5600 okic810 hp1215 hpclj2500 hpclj2600n km-1600 km2530 samclp300 samlp315 lexc500 sihp1000 sihp1005 sihp1018 sihp1020 sihpP1005 sihpP1006 sihpP1505 dl2300 hp-cp1025 km2430"
REQUIRED_USE="|| ( okic301 okic310 okic3200 okic3400 okic511 okic5600 okic810 hp1215 hpclj2500 hpclj2600n km-1600 km2530 samclp300 samlp315 lexc500 sihp1000 sihp1005 sihp1018 sihp1020 sihpP1005 sihpP1006 sihpP1505 dl2300 hp-cp1025 km2430 )"

RDEPEND="net-print/cups
  net-print/foomatic-db
	>=net-print/cups-filters-1.0.43-r1[foomatic]
  app-text/ghostscript-gpl
	virtual/udev"
DEPEND="$RDEPEND"
BDEPEND="app-arch/unzip
	app-editors/vim
	net-misc/wget
	sys-apps/ed
	app-alternatives/bc
  "

SRC_URI="https://foo2zjs.linkevich.net/tarball/${P}.tar.gz"

PATCHES=(
  "${FILESDIR}/0001-Makefile-DESTDIR-support.patch"
  "${FILESDIR}/0002-Makefile-general-fixes.patch"
  #"${FILESDIR}/0003-Rework-firmware-loading.patch"
  "${FILESDIR}/0004-Makefile-fix-generating-.ppd-in-place.patch"
  "${FILESDIR}/0005-Makefile-leverage-default-rules-as-much-as-possible-.patch"
  #"${FILESDIR}/0006-Makefile-do-not-blacklist-usblp-seems-unnecessary-co.patch"
  "${FILESDIR}/0007-Makefile-create-manpages-in-subdirs-via-their-Makefi.patch"
  #"${FILESDIR}/0008-hplj10xx.rules-substitute-PREFIX.patch"
  #"${FILESDIR}/0009-hplj10xx.rules.in-run-firmware-loader-directly.patch"
  "${FILESDIR}/listweb.patch"
  #"${FILESDIR}/unweb.patch"
)

S="${WORKDIR}/${P}/${PN}"
src_unpack() {
  tar xvf ${DISTDIR}/${P}.tar.gz -C ${WORKDIR}
  tar xvf ${WORKDIR}/${P}/${P}.tar.gz -C ${WORKDIR}/${P}
  cd ${S}

  local ppdfiles=()
  local fooprint_list=()
  for flag in ${IUSE}; do
    if use "${flag}"; then
      ppdfiles+=("${flag}.tar.gz")

      case "${flag}" in
      # Handle specific prefix/naming deviations from your list
      okic*) fooprint_list+=("Oki-C${flag#okic}*.xml") ;;
      hp1215) fooprint_list+=("*1215*.xml") ;;
      hpclj*) fooprint_list+=("*${flag#hpclj}*.xml") ;;
      km-*) fooprint_list+=("*magicolor_${flag#km-}*.xml") ;;
      km*) fooprint_list+=("*_${flag#km}*.xml") ;;
      samclp*) fooprint_list+=("Samsung-CLP-${flag#samclp}*.xml") ;;
      samlp*) fooprint_list+=("Samsung-CLP-${flag#samlp}*.xml") ;;
      lexc*) fooprint_list+=("Lexmark-C${flag#lexc}*.xml") ;;
      sihpP*) fooprint_list+=("HP-LaserJet_P${flag#sihpP}*.xml") ;;
      sihp*) fooprint_list+=("HP-LaserJet_${flag#sihp}*.xml") ;;
      dl2300) fooprint_list+=("*2300*.xml") ;;
      hp-cp1025) fooprint_list+=("*CP1025*.xml") ;;
      esac
    fi
  done

  for tarball in ${ppdfiles}; do
    tar xvf ${WORKDIR}/${P}/${tarball} -C ${S}
  done
}

src_prepare() {
  default
  sed -i "s/^FOOPRINT=.*/FOOPRINT=${fooprint_list}/" ${S}/Makefile
  sed -i "s/CFLAGS +=	-O2 -Wall/#CFLAGS +=	-O2 -Wall/g" ${S}/Makefile
  append-cflags -std=gnu11 -Wno-unused-but-set-variable
}

src_compile() {
  export MAKEFLAGS="-j1"
  #emake all ppd
  emake all
}
src_install() {
  dodir usr/share/applications
  dodir usr/share/pixmaps
  dodir usr/share/cups/model
  emake -j1 \
    DESTDIR="${D}" \
    USBDIR="${D}/etc/hotplug/usb" \
    UDEVDIR="${D}/etc/udev/rules.d" \
    DOCDIR="${D}/usr/share/doc/${P}" \
    install
  dodir '/usr/share/licenses/${PF}'
  dodoc COPYING
}
