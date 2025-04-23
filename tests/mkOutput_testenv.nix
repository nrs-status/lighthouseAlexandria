rec {
  flake = builtins.getFlake "path:/home/seba/newEnv/";
  inputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    lighthouseAlexandria = builtins.getFlake "path:/home/seba/lighthouseAlexandria";
  };
  pkgs = import inputs.nixpkgs {};
  exampleOutput = {
    inputs = inputs;
    supportedSystems = [
      "x86_64-linux"
    ];
    envsToProvide = envs: with envs; [
      workEnv
    ];
    packagesToProvide = myPkgs: with myPkgs; [
    ];
  };
  envsdir = "/home/seba/newEnv/pyramid_giza";
  mypkgsdir = "/home/seba/newEnv/temple_artemis_ephesus";
  obj = import ./mkOutput_introspect.nix { inherit envsdir; inherit mypkgsdir; outputsList = [exampleOutput]; };
  mapping_1 = builtins.elemAt obj.mapping 0;
  mapping_2 = builtins.elemAt obj.mapping2 0;
  mkMyPkgs = import ../lib/mkMyPkgs.nix { pkgslib = pkgs.lib; };
  mkMyPkgs_1 = mkMyPkgs { inherit mypkgsdir; flakeInputs = inputs; };

}
