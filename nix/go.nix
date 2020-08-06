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

  goBuild = name: src:
    pkgs.buildGoModule {
      inherit name src;
    };

  goShell = pkgs.mkShell {
    buildInputs = inputs;
  };
in {
  build = goBuild;
  
  shell = goShell;
}
