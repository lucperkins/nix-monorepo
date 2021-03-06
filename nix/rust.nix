let
  # Pinned repos
  sources = import ./sources.nix;

  # Nix overlays from Mozilla
  mozillaOverlay = import sources.nixpkgs-mozilla;

  # Apply the Mozilla overlay to get Rust-specific Nix stuff (tied to specific toolchain)
  pkgs = import sources.nixpkgs {
    overlays = [
      mozillaOverlay
    ];
  };

  # Provide a version of Rust specified in the rust-toolchain file
  rustVersion = toolchain:
    (pkgs.rustChannelOf {
      rustToolchain = toolchain;
    }).rust;

  # Provide a Rust shell based on the local rust-toolchain file
  rustShell = toolchain:
    let
      rust = rustVersion toolchain;
    in pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo-edit
        cargo-watch
        git
        nix
        rust
      ];
    };
in {
  shell = rustShell;
}
