let
  rust = import ../nix/rust.nix;
in rust.build ./rust-toolchain {
  name = "hello";
  version = "0.1.0";
  src = ./.;
}
