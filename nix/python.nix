let
  # Pinned repos
  sources = import ./sources.nix;

  # Pinned pkgs
  pkgs = import sources.nixpkgs {};

  pythonPkgs = pkgs.python38Packages;

  pythonBuild = name: version: srcs:
    pythonPkgs.buildPythonApplication {
      pname = name;

      version = version;

      src = srcs;

      propagatedBuildInputs = with pythonPkgs; [ flask ];
    };

  pythonShell = pkgs.mkShell {
    buildInputs = with pkgs; with pythonPkgs; [
      bpython
      pip
      which
    ];

    shellHook = ''
      pip install -r requirements.txt
      bpython
    '';
  };
in {
  build = pythonBuild;

  shell = pythonShell;
}