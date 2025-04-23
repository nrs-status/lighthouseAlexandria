{ envsdir, mypkgsdir, outputsList }:
rec {
  mapping = builtins.map (outputElm: import ./mkOutputUnit.nix outputElm) outputsList;
  funcForSecondMapping = triple: {
    outputElm = triple.outputElm;
    envs = triple.mkEnvsAttrs {
      inherit envsdir;
      inherit mypkgsdir;
    };
    myPkgs = triple.mkMyPkgs {
      inherit mypkgsdir;
    };
  };
  mapping2 = builtins.map funcForSecondMapping mapping;
  funcForThirdMapping = triple: {
    supportedSystems = triple.outputElm.supportedSystems;
    selectedEnvs = triple.outputElm.envsToProvide triple.envs;
    selectedPkgs = triple.outputElm.packagesToProvide triple.myPkgs;
  };
  mapping3 = builtins.map funcForThirdMapping mapping2;
  nestedFuncForFourthMapping = triple: system: {
    packages.${system} = triple.selectedPkgs;
    devShells.${system} = triple.selectedEnvs;
  };
  funcForFourthMapping = triple: builtins.map (nestedFuncForFourthMapping triple) triple.supportedSystems;
  mapping4 = builtins.map funcForFourthMapping mapping3;
  intraOutputFoldFunction = listOfAttrs: builtins.foldl' (import ./deepMerge.nix) {} listOfAttrs;
  intraOutputFold = builtins.map intraOutputFoldFunction mapping4;
  tracePoint = builtins.trace (builtins.deepSeq intraOutputFold intraOutputFold) intraOutputFold;
  flattening = (import ./flattenList.nix) tracePoint;
  crossOutputFoldFunction = intraOutputFoldFunction; 
}
  
