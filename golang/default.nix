let
  go = import ../nix/go.nix;
in go.build "hello" ./.