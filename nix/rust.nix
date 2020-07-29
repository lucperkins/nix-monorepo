let
  # Pinned repos
  sources = import ./sources.nix;

  # Nix overlays from Mozilla
  mozillaOverlay = import sources.nixpkgs-mozilla;

  # Apply the Mozilla overlay to get Rust-specific Nix stuff
  pkgs = import sources.nixpkgs {
    overlays = [
      mozillaOverlay
    ];
  };

  # Load Naersk from the Niv sources
  naersk = callPackage sources.naersk {};

  # Utilities
  inherit (pkgs) callPackage rustChannelOf;

  # Provide a version of Rust specified in the rust-toolchain file
  rust = toolchain:
    (pkgs.rustChannelOf {
      rustToolchain = toolchain;
    }).rust;

  # Build the Rust project in the specified directory
  buildRustBin = srcs:
    naersk.buildPackage srcs;

  # Provide a Rust shell based on a rust-toolchain file
  rustShell = toolchain:
    pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo-edit
        cargo-watch
        git
        (rust toolchain)
      ];
    };
in {
  shell = rustShell;
  
  build = buildRustBin;
}
