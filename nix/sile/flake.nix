{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=22.05-beta";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
    sile = pkgs.sile.overrideAttrs(oldAttrs: { doCheck = false; });
  in {
    packages.sile = sile;
    apps.sile = {
      type = "app";
      program = "${sile}/bin/sile";
    };
    devShell = pkgs.mkShell {
      buildInputs = [ sile ];
    };
  });
}
