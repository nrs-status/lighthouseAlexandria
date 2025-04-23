{ pkgslib }:
{ filePath, inputForImportPairs, activateDebug ? false }:
let total = rec {
  filesList = (import ./listDirIgnoring.nix { inherit pkgslib; }) {
    ignore = [];
    dir = filePath;
  };
  functionToMap = path: import ./mkImportPair.nix { inherit pkgslib; } { importInputs = inputForImportPairs; filePath = path; };
  importPairList = builtins.map functionToMap filesList;
  final = builtins.listToAttrs importPairList;

}; in (import ./withDebug.nix) activateDebug {
  debug = total;
  nondebug = total.final;
}
