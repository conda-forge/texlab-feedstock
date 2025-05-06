#!/usr/bin/env bash
# NOTE: mostly derived from
# https://github.com/conda-forge/py-spy-feedstock/blob/master/recipe/build.sh

set -o xtrace -o nounset -o pipefail -o errexit

_UNAME=$(uname -s)

if [[ "${_UNAME}" = "Darwin" ]] ; then
  export RUSTFLAGS="-C link-args=-Wl,-rpath,${PREFIX}/lib"
else
  export RUSTFLAGS="-C link-arg=-Wl,-rpath-link,${PREFIX}/lib -L${PREFIX}/lib"
fi

export CARGO_PROFILE_RELEASE_STRIP=symbols

# build statically linked binary with Rust
cargo install \
  --locked \
  --no-track \
  --profile release \
  --root "${PREFIX}" \
  --path crates/texlab

# dump licenses
cargo-bundle-licenses \
  --format yaml \
  --output "${SRC_DIR}/THIRDPARTY.yml"
