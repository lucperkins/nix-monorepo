let
  rust = import ../nix/rust.nix;
in rust.build ./.