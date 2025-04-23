{ inputs, myPkgs, target, newNixpkgsPackageList, newLocalPackageList, shellHookExtension, activateDebug ? false }:
let total = rec {
  targetTotal = import target {
    inherit inputs myPkgs;
    activateDebug = true;
  }; 
  resultingNixpkgsPackageList = targetTotal.packagesFromNixpkgs ++ newNixpkgsPackageList;
  resultingLocalPackageList = targetTotal.packagesFromLocalRepo ++ newLocalPackageList;
  resultingShellHook = targetTotal.shellHook + shellHookExtension;
  final = targetTotal.pkgs.mkShell {
    packages = resultingNixpkgsPackageList ++ resultingLocalPackageList;
    shellHook = resultingShellHook;
  };
}; in inputs.libs.baselib.withDebug activateDebug {
  nondebug = total.final;
  debug = total;
}
