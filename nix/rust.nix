let
  # Pinned repos
  sources = import ./sources.nix;

  # Nix overlays from Mozilla
  mozillaOverlay = import sources.nixpkgs-mozilla;

  # Apply the Mozilla overlay to get Rust-specific Nix stuff (tied to specific toolchain)
  rustPkgs = toolchain:
    let
      rust = rustVersion toolchain;
    in
      import sources.nixpkgs {
        overlays = [
          mozillaOverlay
          (self: super:
            {
              rustc = rust;
              cargo = rust;
            }
          )
        ];
      };

  # Provide a version of Rust specified in the rust-toolchain file
  rustVersion = toolchain:
    let
      pkgs = rustPkgs toolchain;
    in
      (pkgs.rustChannelOf {
        rustToolchain = toolchain;
      }).rust;

  # Build the Rust project in the specified directory
  # Important drawback: Naersk can't be pinned to specific Rust versions :/
  buildRustBin = srcs: toolchain:
    let
      pkgs = rustPkgs toolchain;

      naersk = pkgs.callPackage sources.naersk {};
    in naersk.buildPackage srcs;

  # Provide a Rust shell based on a rust-toolchain file
  rustShell = toolchain:
    let
      pkgs = rustPkgs toolchain;
    in pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo-edit
        cargo-watch
        git
        (rustVersion toolchain)
      ];
    };
in {
  shell = rustShell;
  
  build = buildRustBin;
}
