let
  sources = import ./sources.nix;
  pkgs = import sources.nixpkgs {};

  inherit (pkgs) dockerTools;

  dockerBuild = name: contents:
    dockerTools.buildLayeredImage {
      inherit contents name;

      config = {
        Cmd = [ "/bin/${name}" ];
        WorkingDir = "/";
      };
    };
in {
  build = dockerBuild;
}