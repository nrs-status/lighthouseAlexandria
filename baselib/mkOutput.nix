{ pkgslib }:
{ envsdir, mypkgsdir, outputsList, activateDebug ? false }:
let total = rec {
  inherit outputsList;
  mapping = builtins.map (outputElm: import ./mkOutputUnit.nix outputElm) outputsList;
  nestedFuncForSecondMapping = triple: let
      systems = triple.outputElm.supportedSystems;
      funcToMapOverSystems = (system: {
        outputElm = triple.outputElm;
        envs = triple.intermediateMkEnvsAttrs {
          inherit envsdir;
          inherit mypkgsdir;
          inherit system;
        };
        myPkgs = triple.intermediateMkMyPkgs {
          inherit mypkgsdir;
          inherit system;
        };});
        in pkgslib.genAttrs systems funcToMapOverSystems; 
  mapping2 = builtins.map nestedFuncForSecondMapping mapping;
  #result: list containing attribute sets whose keys are systems
  attrsMapForThirdMap = key: triple: {
    selectedEnvs = triple.outputElm.envsToProvide triple.envs;
    selectedPkgs = triple.outputElm.packagesToProvide triple.myPkgs;
  };
  mapping3 = builtins.map (attrs: builtins.mapAttrs attrsMapForThirdMap attrs) mapping2;
  attrsMapForFourthMap = key: val: {
    packages.${key} = val.selectedPkgs;
    devShells.${key} = val.selectedEnvs;
  };
  mapping4 = builtins.map (attrs: builtins.mapAttrs attrsMapForFourthMap attrs) mapping3;
  removeSystemFromKey = builtins.map (attrs: builtins.attrValues attrs) mapping4;
  foldForEachOutput = listOfAttrs: builtins.foldl' (import ./deepMerge.nix) {} listOfAttrs;
  mapping5 = builtins.map foldForEachOutput removeSystemFromKey;
  final = foldForEachOutput mapping5;
}; in (import ./withDebug.nix) activateDebug {
  debug = total;
  nondebug = total.final;
}
  
