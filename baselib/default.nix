{ pkgslib, nixvimFlake }:
{
  mkOutput = import ./mkOutput.nix { inherit pkgslib; };
  preMkNixvim = import ./nixvim/mkNixvim.nix { inherit pkgslib; inherit nixvimFlake; }; #still needs pkgs and system, which are passed directly at montezuma_circles_scroll;
  concatAttrSets = import ./concatAttrSets.nix;
  importPairAttrsOfDir = import ./importPairAttrsOfDir.nix { inherit pkgslib; };
  attrsSubtype = import ./attrsSubtype.nix;
  withDebug = import ./withDebug.nix;
  extendNixvimEnvAttrs1 = import ./nixvim/extendNixvimEnvAttrs1.nix;
  extendEnv = import ./extendEnv.nix;
}

