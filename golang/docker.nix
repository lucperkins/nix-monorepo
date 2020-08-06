let
  docker = import ../nix/docker.nix;
  hello = import ./default.nix;

  name = "hello-go";

  contents = [ hello ];
in docker.build name contents