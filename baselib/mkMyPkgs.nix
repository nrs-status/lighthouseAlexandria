{ pkgslib }:
{ mypkgsdir, flakeInputs }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
  filePath = mypkgsdir;
  inputForImportPairs = {
    inherit flakeInputs;
  };
}
