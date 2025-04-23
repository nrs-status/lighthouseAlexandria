{ pkgs, makerFunc, lib, symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
let 
  argToNixvimMaker = {
    module = (import etc) // {
      opts = import opts { inherit lib; };
      inherit filetype;
      inherit keymaps;
      extraConfigLua = lib.concatAttrSets extraConfigLuaList;
      inherit extraPlugins;
      plugins = let
          importMapping = builtins.map (path: import path { inherit lib;}) pluginsList;
      in lib.concatAttrSets importMapping;
    };
  };
in
  pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = extraPackages ++ makerFunc argToNixvimMaker;
  }

