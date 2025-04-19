outputElm:
let
  pkgs = import outputElm.inputs.nixpkgs {};
in
rec {
  inherit outputElm;
  mkMyPkgs = { mypkgsdir }: (import ./lib/mkMyPkgs.nix { pkgslib = pkgs.lib; }) {
    inherit mypkgsdir;
    flakeInputs = outputElm.inputs;
  };
  mkEnvsAttrs = { mypkgsdir, envsdir }: (import ./lib/mkEnvsAttrs.nix { pkgslib = pkgs.lib; }) {
    inherit envsdir;
    nixpkgsFlakeInputAsPkgs = pkgs;
    myPkgs = mkMyPkgs mypkgsdir;
  };
}
