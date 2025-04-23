{ inputs, myPkgs, target, newNixpkgsPackageList, newLocalPackageList, shellHookExtension, activateDebug ? false }:
let total = {
  targetTotal = import target {
    inherit inputs myPkgs;
    activateDebug = true;
  }; 
  resultingNixpkgsPackageList = target.packagesFromNixpkgs ++ newNixpkgsPackageList;
  resultingLocalPackageList = target.packagesFromLocalRepo ++ newLocalPackageList;
  resultingShellHook = target.shellHook + shellHookExtension;
  final = target.pkgs.mkShell {
    packages = resultingNixpkgsPackageList + resultingLocalPackageList;
    shellHook = resultingShellHook;
  };
}; in inputs.libs.baselib.withDebug activateDebug {
  nondebug = total.final;
  debug = total;
};
