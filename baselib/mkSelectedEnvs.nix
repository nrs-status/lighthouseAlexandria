{ pkgslib }:
{ reader, mypkgsdir, envsdir, activateDebug ? false}:
let total = rec {
  mkMyPkgs = import ./mkMyPkgs.nix { inherit pkgslib; };
  myPkgs = mkMyPkgs {
    inherit mypkgsdir;
    inputs = reader.inputs;
    system = reader.system;
  };
  mkEnvsAttrs = import ./mkEnvsAttrs.nix { inherit pkgslib; };
  envsAttrs = mkEnvsAttrs {
    inherit envsdir myPkgs;
    inputs = reader.inputs;
  };
  selectedEnvs = pkgslib.attrsets.genAttrs reader.envsToProvide (label: envsAttrs.${label});
  final = selectedEnvs;
}; in (import ./wrapDebug.nix) { 
  inherit total activateDebug;
}
