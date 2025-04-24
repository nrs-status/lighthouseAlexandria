rec {
  flakes = {
    lighthouseAlexandria = builtins.getFlake "path:/home/sieyes/baghdad_plane/flakes/lighthouseAlexandria";
    colossusRhodes = builtins.getFlake "/home/sieyes/baghdad_plane/flakes/colossusRhodes";
  };
  libs = {
    pkgslib = flakes.lighthouseAlexandria.pkgslib;
    baselib = flakes.lighthouseAlexandria.baselib;
    typechecklib = flakes.colossusRhodes.typechecklib {
      typesSource = /home/sieyes/baghdad_plane/flakes/newEnv/mauso_halicarnassus;
    };
  };
  mockInputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    pkgs = import (builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable") {};
    nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
    lighthouseAlexandria = flakes.lighthouseAlexandria;
    inherit libs;
    colossusRhodes = flakes.colossusRhodes;
  };
  exampleOutput = {
    inputs = mockInputs;
    supportedSystems = [
      "x86_64-linux"
    ];
    envsToProvide = [
      "workEnv"
      "androidEnv"
    ];
    packagesToProvide = [
      ["nixvim" "base" ]
      "androidsdk"
    ];
  };
  mkOutput = import ../baselib/mkOutput.nix { pkgslib = libs.pkgslib; };
  result = mkOutput {
    envsdir = /home/sieyes/baghdad_plane/flakes/newEnv/pyramid_giza;
    mypkgsdir = /home/sieyes/baghdad_plane/flakes/newEnv/temple_artemis_ephesus;
    outputDeclList = [ exampleOutput ];
    activateDebug = true;
  };
  
}
