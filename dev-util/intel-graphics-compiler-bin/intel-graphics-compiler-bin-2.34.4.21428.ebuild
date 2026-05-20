# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_cut 1-3)"
MY_REV="$(ver_cut 4)"

DESCRIPTION="Intel Graphics Compiler (binary) from Intel .deb releases"
HOMEPAGE="https://github.com/intel/intel-graphics-compiler"
SRC_URI="
	https://github.com/intel/intel-graphics-compiler/releases/download/v${MY_PV}/intel-igc-core-2_${MY_PV}+${MY_REV}_amd64.deb -> intel-igc-core-2_${MY_PV}.deb
	https://github.com/intel/intel-graphics-compiler/releases/download/v${MY_PV}/intel-igc-core-devel_${MY_PV}+${MY_REV}_amd64.deb -> intel-igc-core-devel_${MY_PV}.deb
	https://github.com/intel/intel-graphics-compiler/releases/download/v${MY_PV}/intel-igc-opencl-2_${MY_PV}+${MY_REV}_amd64.deb -> intel-igc-opencl-2_${MY_PV}.deb
	https://github.com/intel/intel-graphics-compiler/releases/download/v${MY_PV}/intel-igc-opencl-devel_${MY_PV}+${MY_REV}_amd64.deb -> intel-igc-opencl-devel_${MY_PV}.deb
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="strip"

PROVIDE="dev-util/intel-graphics-compiler-2.34.4.21428
         dev-util/intel-graphics-compiler"

RDEPEND="dev-util/spirv-tools"

DESCRIPTION="Binary packaging of Intel IGC (core + opencl + devel) from Intel .deb releases"

src_unpack() {
  local deb
  for deb in ${A}; do
    mkdir -p "${WORKDIR}/${deb%.deb}" || die
    cd "${WORKDIR}/${deb%.deb}" || die

    unpack "${deb}"
    unpack "${WORKDIR}/${deb%.deb}/data.tar.gz"
  done
}

src_install() {
  local dir d

  for dir in "${WORKDIR}"/intel-igc-*; do
    [[ -d ${dir} ]] || continue

    for d in usr opt etc; do
      [[ -d "${dir}/${d}" ]] || continue

      if [[ ${d} == "usr" ]]; then
        # 1. Handle the specialized lib mappings first
        if [[ -d "${dir}/usr/local/lib" ]]; then
          mkdir -p "${ED}/usr/lib64" || die
          cp -a "${dir}/usr/local/lib"/* "${ED}/usr/lib64/" || die
        fi

        if [[ -d "${dir}/usr/lib" ]]; then
          mkdir -p "${ED}/usr/lib64" || die
          cp -a "${dir}/usr/lib"/* "${ED}/usr/lib64/" || die
        fi

        # 2. Chuck everything else from /usr/local into /usr (ignoring lib)
        if [[ -d "${dir}/usr/local" ]]; then
          local item
          for item in "${dir}/usr/local"/*; do
            [[ -e ${item} ]] || continue
            # Skip the lib folder we already handled
            [[ $(basename "${item}") == "lib" ]] && continue

            # This will copy 'include', 'share', etc., straight into ${ED}/usr/
            cp -a "${item}" "${ED}/usr/" || die
          done
        fi

        # 3. Chuck everything else from /usr into /usr (ignoring local and lib)
        local item
        for item in "${dir}/usr"/*; do
          [[ -e ${item} ]] || continue
          local bname=$(basename "${item}")
          [[ ${bname} == "local" || ${bname} == "lib" ]] && continue

          cp -a "${item}" "${ED}/usr/" || die
        done

      else
        # For opt and etc, just copy them exactly as they are
        cp -a "${dir}/${d}" "${ED}/" || die "Failed to copy ${d} from $(basename "${dir}")"
      fi
    done
  done

  # Clean up documentation and static/libtool archives
  rm -rf "${ED}/usr/share/doc" \
    "${ED}/usr/share/man" \
    "${ED}/usr/share/info" \
    "${ED}/usr/lib64"/*.la || true

  # patch /usr/local
  sed -i 's/prefix=\/usr\/local/prefix=\/usr/' "${ED}/usr/lib64/pkgconfig/igc-opencl.pc" || die
}

pkg_postinst() {
  if [ -x /sbin/ldconfig ]; then
    ebegin "Updating shared library cache"
    /sbin/ldconfig || eend 1 "ldconfig failed"
    eend 0
  fi
}

S="${WORKDIR}"
