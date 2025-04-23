rec {
  flake = builtins.getFlake "path:/home/seba/newEnv/";
  inputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
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
  mkOutputUnit = import ../lib/mkOutputUnit.nix;
  obj = mkOutputUnit exampleOutput;
}
