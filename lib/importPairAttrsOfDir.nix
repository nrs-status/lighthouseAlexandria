{ pkgslib }:
{ filePath, inputForImportPairs }:
let
  filesList = (import ./listDirIgnoring.nix { inherit pkgslib; }) {
    ignore = [];
    dir = filePath;
  };
  functionToMap = path: import ./mkImportPair.nix { inherit pkgslib; } { importInputs = inputForImportPairs; filePath = path; };
  importPairList = builtins.map functionToMap filesList;
in
builtins.listToAttrs importPairList
