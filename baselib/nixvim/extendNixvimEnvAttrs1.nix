{ envAttrsToExtend, symlinkJoinName, plugins }:
envAttrsToExtend // {
  inherit symlinkJoinName;
  pluginsList = envAttrsToExtend.plugins ++ plugins;
}

