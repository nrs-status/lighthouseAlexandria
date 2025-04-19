{ pkgslib }:
{ envsdir, nixpkgsFlakeInputAsPkgs, myPkgs }:
(import ./dirToImportPairAttrs.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      pkgs = nixpkgsFlakeInputAsPkgs;
      inherit myPkgs;
    };
}


