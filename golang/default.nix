let
  go = import ../nix/go.nix;
in go.build {
  pname = "hello";
  version = "0.1.0";
  src = ./.;
}