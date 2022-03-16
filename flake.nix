{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShell = pkgs.mkShell {
            buildInputs = [
              pkgs.texlive.combined.scheme-basic
              (pkgs.rstudioWrapper.override {
                packages = with pkgs;[
                  rPackages.DBI
                  rPackages.RPostgres
                  rPackages.readr
                  rPackages.openxlsx
                  rPackages.dplyr
                  rPackages.plotly
                  rPackages.randomForest
                  rPackages.magrittr
                ];
              })
            ];
          };
        }
      );
}
