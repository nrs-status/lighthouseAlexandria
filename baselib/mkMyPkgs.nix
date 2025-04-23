{ pkgslib }:
{ mypkgsdir, flakeInputs, system }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
  filePath = mypkgsdir;
  inputForImportPairs = {
    inherit flakeInputs;
    inherit system;
  };
}
