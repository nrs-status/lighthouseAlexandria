{ pkgslib }:
{ mypkgsdir, inputs, system }:
(import ./importPairAttrsOfDir.nix { inherit pkgslib; }) {
  filePath = mypkgsdir;
  inputForImportPairs = {
    inherit inputs;
    inherit system;
  };
}
