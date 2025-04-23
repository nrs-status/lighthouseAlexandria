{ pkgslib }:
{ envsdir, nixpkgsFlakeInputAsPkgs, myPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      pkgs = nixpkgsFlakeInputAsPkgs;
      inherit myPkgs;
    };
}


