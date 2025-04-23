{ pkgslib }:
{
  mkOutput = import ./mkOutput.nix { inherit pkgslib; };
  mkNixvim = import ./nixvim/mkNixvim.nix;
  concatAttrSets = import ./concatAttrSets.nix;
  importPairAttrsOfDir = import ./importPairAttrsOfDir.nix { inherit pkgslib; };
  attrsSubtype = import ./attrsSubtype.nix;
  withDebug = import ./withDebug.nix;
}

