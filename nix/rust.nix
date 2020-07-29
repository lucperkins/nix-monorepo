let
  sources = import ./sources.nix;
  mozilla = import sources.nixpkgs-mozilla;
  pkgs = import sources.nixpkgs {
    overlays = [ mozilla ];
  };

  inherit (pkgs) rustChannelOf;

  rust = toolchain:
    (pkgs.rustChannelOf {
      rustToolchain = toolchain;
    }).rust;
in {
  pkgs = pkgs;

  shell = toolchain:
    pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo-watch
        (rust toolchain)
      ];
    };
}
