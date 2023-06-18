{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    sile.url = "github:sile-typesetter/sile";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, sile, flake-utils}: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
    zola = pkgs.zola;
  in with pkgs;
  {
    packages = {
      inherit zola sytem-sile;
    };
    apps = {
      zola = {
        type = "app";
        program = "${zola}/bin/zola";
      };
      sile = sile.defaultApp.${system};
    };
    devShell = mkShell {
      buildInputs = [ zola sile.defaultPackage.${system} ];
    };
  });
}
