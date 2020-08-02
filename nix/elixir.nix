# This approach is indebted to: https://ghedam.at/15443/a-nix-shell-for-developing-elixir

let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};

  inherit (pkgs.lib) optional optionals;
  inherit (pkgs.stdenv) isDarwin isLinux;

  elixirShell = pkgs.mkShell {
    buildInputs = with pkgs; [
      elixir_1_10
      yarn
    ]
      ++ optional isLinux inotify-tools
      ++ optionals isDarwin (with darwin.apple_sdk.frameworks; [
        CoreFoundation
        CoreServices
      ]);
  };
in {
  shell = elixirShell;
}