outputElm:
let
  pkgs = import outputElm.inputs.nixpkgs {};
in
rec {
  inherit outputElm;
  intermediateMkMyPkgs = { mypkgsdir, system }: (import ./mkMyPkgs.nix { pkgslib = pkgs.lib; }) {
    inherit mypkgsdir;
    inputs = outputElm.inputs;
    inherit system;
  };
  intermediateMkEnvsAttrs = { mypkgsdir, envsdir, system }: (import ./mkEnvsAttrs.nix { pkgslib = pkgs.lib; }) {
    inherit envsdir;
    nixpkgsFlakeInputAsPkgs = pkgs;
    myPkgs = intermediateMkMyPkgs { inherit mypkgsdir; inherit system; };
  };
}
