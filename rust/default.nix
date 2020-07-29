let
  rust = import ../nix/rust.nix;
in rust.build ./. ./rust-toolchain