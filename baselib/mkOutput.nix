{ pkgslib }:
{ envsdir, mypkgsdir, outputDeclList, activateDebug ? false}:
let total = rec {
  reader = form : { inherit form; next = x : reader (form // x); };
  mkSelectedEnvs = readerToRun: import ./mkSelectedEnvs.nix { inherit pkgslib; } {
    inherit mypkgsdir envsdir;
    reader = readerToRun;
  };
  mkSelectedPackages = readerToRun: import ./mkSelectedPackages.nix { inherit pkgslib; } { 
    inherit mypkgsdir;
    reader = readerToRun;
  };
initReaderWith = funcToApply: decl: pkgslib.attrsets.genAttrs decl.supportedSystems (system: funcToApply (reader {
    inputs = decl.inputs;
    inherit system;
    packagesToProvide = decl.packagesToProvide;
    envsToProvide = decl.envsToProvide;
  }).form);
  unrealizedSelectedPackages = initReaderWith mkSelectedPackages;
  unrealizedSelectedEnvs = initReaderWith mkSelectedEnvs;
  selectedPackages = map unrealizedSelectedPackages outputDeclList;
  selectedEnvs = map unrealizedSelectedEnvs outputDeclList;
  deepMerge = import ./deepMerge.nix;
  foldIntoPackagesVal = builtins.foldl' deepMerge {} selectedPackages;
  foldIntoDevShellsVal = builtins.foldl' deepMerge {} selectedEnvs;
  final = { 
    packages = foldIntoPackagesVal;
    devShells = foldIntoDevShellsVal;
  };
};
in (import ./wrapDebug.nix) {
  inherit total activateDebug;
}
