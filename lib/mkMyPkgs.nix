{ pkgslib }:
{ mypkgsdir, flakeInputs }:
(import ./dirToImportPairAttrs.nix { inherit pkgslib; }) {
  filePath = mypkgsdir;
  inputForImportPairs = {
    inherit flakeInputs;
  };
}
