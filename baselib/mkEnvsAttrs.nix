{ pkgslib }:
{ envsdir, inputs, myPkgs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
    filePath = envsdir;
    inputForImportPairs = {
      inherit inputs myPkgs;
    };
}


