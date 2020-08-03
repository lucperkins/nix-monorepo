# This approach is indebted to: https://ghedam.at/15443/a-nix-shell-for-developing-elixir

let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};

  inherit (pkgs.lib) optional optionals;
  inherit (pkgs.stdenv) isDarwin isLinux mkDerivation;

  inputs = with pkgs; [
    elixir_1_10
    yarn
  ];

  elixirShell = pkgs.mkShell {
    buildInputs = with pkgs; inputs
      # OS-specific notification tools for "mix phx.server"
      ++ optional isLinux inotify-tools
      ++ optionals isDarwin (with darwin.apple_sdk.frameworks; [
        CoreFoundation
        CoreServices
      ]);
  };
in {
  shell = elixirShell;
}