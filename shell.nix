let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in pkgs.mkShell {
  buildInputs = [];

  shellHook = ''
    function welcome {
      echo "Welcome to the shell!"
    }
  '';
}