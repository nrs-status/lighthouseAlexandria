outputElm:
let
  pkgs = import outputElm.inputs.nixpkgs {};
in
rec {
  inherit outputElm;
  mkMyPkgs = { mypkgsdir, system }: (import ./mkMyPkgs.nix { pkgslib = pkgs.lib; }) {
    inherit mypkgsdir;
    flakeInputs = outputElm.inputs;
    inherit system;
  };
  mkEnvsAttrs = { mypkgsdir, envsdir, system }: (import ./mkEnvsAttrs.nix { pkgslib = pkgs.lib; }) {
    inherit envsdir;
    nixpkgsFlakeInputAsPkgs = pkgs;
    myPkgs = mkMyPkgs { inherit mypkgsdir; inherit system; };
  };
}
