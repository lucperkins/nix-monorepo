let
  # Pinned repos
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};

  # Go tools
  inputs = with pkgs; [
    git
    go
    goimports
  ];

  goShell = pkgs.mkShell {
    buildInputs = inputs;
  };
in {
  shell = goShell;
}
