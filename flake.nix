{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}: flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs { inherit system; };
    zola = pkgs.zola;
  in with pkgs;
  {
    packages = {
      inherit zola;
    };
    devShell = mkShell {
      buildInputs = [ zola ];
    };
  });
}
