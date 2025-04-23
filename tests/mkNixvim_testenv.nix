rec {
  flake = builtins.getFlake "path:/home/seba/newEnv/";
  inputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    lighthouseAlexandria = builtins.getFlake "path:/home/seba/lighthouseAlexandria";
    nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
  };
  pkgs = import inputs.nixpkgs {};
  lib = inputs.lighthouseAlexandria.lib { typesSource = /home/seba/newEnv/mauso_halicarnassus; };
  baseImport = import /home/seba/newEnv/temple_artemis_ephesus/montezuma_circles_scroll/envAttrs/base.nix;
  mkNixvimInput = baseImport // {
    inherit pkgs;
    makerFunc = inputs.nixvimFlakeInput.legacyPackages."x86_64-linux".makeNixvimWithModule;
    inherit lib;
  };
  mkNixvim = lib.mkNixvim;
  importMapping = builtins.map (path: import path { inherit lib; }) baseImport.pluginsList;
  plugins = lib.concatAttrSets importMapping;
  x = /home/seba/newEnv/temple_artemis_ephesus/montezuma_circles_scroll;
  pluginsList = builtins.map (path: /home/seba/newEnv/temple_artemis_ephesus/montezuma_circles_scroll/resources/plugins + path) [
    /cmp.nix
    /resources/plugins/lsp.nix
    /resources/plugins/pluginsCore.nix
  ];
  result = mkNixvim mkNixvimInput;
}
