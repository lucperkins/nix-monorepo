let
  # Pinned repos
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};

  inherit (pkgs.lib) fakeSha256;

  buildGoBin = pkgs.buildGoModule;

  goShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      git
      go
      goimports
    ];
  };
in {
  shell = goShell;

  build = buildGoBin;

  fakeSha = fakeSha256;
}
