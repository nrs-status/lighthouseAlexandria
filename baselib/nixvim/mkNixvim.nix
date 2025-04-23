{ pkgslib, nixvimFlake, activateDebug ? false }:
{ inputs, system }:
{symlinkJoinName, etc, keymaps, opts, filetype, pluginsList, extraPlugins, extraConfigLuaList, extraPackages}:
let total = rec {
  nixvimMaker = nixvimFlake.legacyPackages.${system}.makeNixvimWithModule;
  extraConfigLua = builtins.foldl' (acc: next: acc + builtins.readFile next) "" extraConfigLuaList;
  argToNixvimMaker = {
    module = (import etc {}) // {
      opts = import opts { inherit pkgslib; inherit inputs; };
      inherit filetype;
      keymaps = import keymaps {};
      inherit extraConfigLua;
      inherit extraPlugins;
      plugins = let
          importMapping = builtins.map (path: import path { inherit inputs; inherit system;}) pluginsList;
      in inputs.libs.baselib.concatAttrSets importMapping;
    };
  }; 
};
in (import ../withDebug.nix activateDebug) {
  debug = total;
  nondebug = inputs.pkgs.symlinkJoin {
    name = symlinkJoinName;
    paths = [(total.nixvimMaker total.argToNixvimMaker)];
    #paths = extraPackages ++ [ (total.nixvimMaker total.argToNixvimMaker) ];
};
}

