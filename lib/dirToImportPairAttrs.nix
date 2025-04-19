{ pkgslib }:
{ filePath, inputForImportPairs }:
let
  filesList = (import ./listDirIgnoring.nix { inherit pkgslib; }) {
    ignore = [];
    dir = filePath;
  };
  importPairList = builtins.map (import ./mkImportPair.nix { inherit pkgslib; }) {
    importInputs = inputForImportPairs;
    inherit filePath;
  };
in
builtins.listToAttrs importPairList
