let
  python = import ../nix/python.nix;
in python.build "hello" "0.1.0" ./.