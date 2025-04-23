{ pkgslib, nixvimFlakeInput }:
{ pkgs, system }:
{symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
let total = {
  nixvimMaker = nixvimFlakeInput.legacyPackages.${system}.makeNixvimWithModule;
  argToNixvimMaker = {
    module = (import etc) // {
      opts = import opts { inherit pkgslib; };
      inherit filetype;
      inherit keymaps;
      extraConfigLua = pkgslib.concatAttrSets extraConfigLuaList;
      inherit extraPlugins;
      plugins = let
          importMapping = builtins.map (path: import path { inherit pkgslib;}) pluginsList;
      in pkgslib.concatAttrSets importMapping;
    };
  }; 
};
in pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = extraPackages ++ total.nixvimMaker total.argToNixvimMaker;
}

