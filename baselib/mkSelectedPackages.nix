{ pkgslib }:
{ reader, mypkgsdir, activateDebug ? false }:
let total = rec {
  mkMyPkgs = import ./mkMyPkgs.nix { inherit pkgslib; };
  myPkgs = mkMyPkgs {
    inherit mypkgsdir;
    inputs = reader.inputs;
    system = reader.system;
  };
  pkgOfPath = path: { 
    key = path;
    val = pkgslib.attrsets.attrByPath path (throw "mkOutput.nix failed to find path") myPkgs;
  };
  pkgOfLabel = label: {
    key = label;
    val = myPkgs.${label};
  };
    
  triageElm = elm: 
    if builtins.isList elm then
      pkgOfPath elm
    else if builtins.isString elm then
      pkgOfLabel elm
    else throw "mkOutput.nix wrong label type during triage";
  selectedPackagesAsKeyValPairs = builtins.map triageElm reader.packagesToProvide;
  keyValPairsAsSingleKeyAttrs = attrs:
    if builtins.isList attrs.key then
      pkgslib.attrsets.setAttrByPath attrs.key attrs.val
    else if builtins.isString attrs.key then
      { attrs.key = attrs.val; }
    else throw "mkSelectedPkgs.nix wrong type for package label";
  deepMerge = import ./deepMerge.nix;
  foldIntoAttrs = builtins.foldl' deepMerge {} (builtins.map keyValPairsAsSingleKeyAttrs selectedPackagesAsKeyValPairs);
  final = foldIntoAttrs;
}; in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
