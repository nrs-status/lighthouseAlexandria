outputElm:
rec {
  inherit outputElm;
  intermediateMkMyPkgs = { mypkgsdir, system }: (import ./mkMyPkgs.nix { pkgslib = outputElm.inputs.libs.pkgslib; }) {
    inherit mypkgsdir;
    inputs = outputElm.inputs;
    inherit system;
  };
  intermediateMkEnvsAttrs = { mypkgsdir, envsdir, system }: (import ./mkEnvsAttrs.nix { pkgslib = outputElm.inputs.libs.pkgslib; }) {
    inherit envsdir;
    inputs = outputElm.inputs;
    myPkgs = intermediateMkMyPkgs { inherit mypkgsdir; inherit system; };
  };
}
