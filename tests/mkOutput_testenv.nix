rec {
  flakes = {
    lighthouseAlexandria = builtins.getFlake "github:nrs-status/lighthouseAlexandria";
  };
  libs = {
    pkgslib = flakes.lighthouseAlexandria.pkgslib;
    baselib = flakes.lighthouseAlexandria.baselib;
  };
  mockInputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
    lighthouseAlexandria = builtins.getFlake "github:nrs-status/lighthouseAlexandria";
  };
  exampleOutput = {
    inputs = mockInputs;
    supportedSystems = [
      "x86_64-linux"
    ];
    envsToProvide = envs: with envs; [
      workEnv
    ];
    packagesToProvide = myPkgs: with myPkgs; [
    ];
  };
  mkOutput = libs.baselib.mkOutput {
    envsdir = /home/sieyes/baghdad_plane/flakes/newEnv/pyramid_giza;
    mypkgsdir = /home/sieyes/baghdad_plane/flakes/newEnv/temple_artemis_ephesus;
    outputsList = [ exampleOutput ];
  };
  
}
