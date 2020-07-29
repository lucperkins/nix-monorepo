let
  sources = import ./sources.nix;
  mozillaOverlay = import sources.nixpkgs-mozilla;
  pkgs = import sources.nixpkgs {
    overlays = [
      mozillaOverlay
    ];
  };

  naersk = callPackage sources.naersk {};

  inherit (pkgs) callPackage rustChannelOf;

  # Provide a version of Rust specified in the rust-toolchain file
  rust = toolchain:
    (pkgs.rustChannelOf {
      rustToolchain = toolchain;
    }).rust;

  buildRustBin = srcs:
    naersk.buildPackage srcs;
in {
  pkgs = pkgs;

  shell = toolchain:
    pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo-watch
        (rust toolchain)
      ];
    };
  
  build = buildRustBin;
}
