#!/bin/sh
SRCDIR="${HOME}/Source/limusic"
FILESDIR="$(pwd)/files"
PV="1.4.1"

cd "${SRCDIR}"
git checkout "v${PV}"

rm -rf vendor

cargo vendor --versioned-dirs

# Patch the versioned Lindera crate directory (cargo vendor uses
# lindera-ipadic-<version> when --versioned-dirs is enabled).
local_build_rs=$(find vendor -maxdepth 2 -type f -path 'vendor/lindera-ipadic-*/build.rs' -print -quit)
if [ -z "${local_build_rs}" ]; then
  echo "Could not find vendor/lindera-ipadic-*/build.rs" >&2
  exit 1
fi

sed -i \
  -e '/use std::fs::{create_dir, rename, File};/s/create_dir, rename, File/create_dir, copy, File/' \
  -e '/let tmp_path = Path::new(&build_dir)/,/rename(tmp_path, &source_path_for_build).expect("Failed to rename temporary file");/c\
            let source_path = env::var_os("LINDERA_IPADIC_TARBALL")\
                .ok_or("LINDERA_IPADIC_TARBALL must point to the IPADIC source archive")?;\
            copy(source_path, \&source_path_for_build)?;' \
  "${local_build_rs}" || exit 1

local_crate_dir=${local_build_rs%/build.rs}
local_checksum_file="${local_crate_dir}/.cargo-checksum.json"
local_build_hash=$(sha256sum "${local_build_rs}") || exit 1
local_build_hash=${local_build_hash%% *}

grep -q '"build.rs"' "${local_checksum_file}" || {
  echo "build.rs checksum entry not found in ${local_checksum_file}" >&2
  exit 1
}
sed -i -E \
  "s/(\"build.rs\":\"?)[0-9a-f]{64}/\1${local_build_hash}/" \
  "${local_checksum_file}" || exit 1

rm -f "${FILESDIR}/cargo-${PV}.tar.zst"
tar cvf "${FILESDIR}/cargo-${PV}.tar.zst" -I 'zstd -T0 --ultra -22' vendor

cd ui
rm -rf node_modules
rm -f "${FILESDIR}/node_modules-${PV}.tar.xz"

pnpm fetch --frozen-lockfile --store-dir "${SRCDIR}/ui/node_modules"
tar cvf "${FILESDIR}/node_modules-${PV}.tar.xz" -I 'xz -T0 -9e' node_modules
