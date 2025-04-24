{ envAttrsToExtend, symlinkJoinName, plugins }:
envAttrsToExtend // {
  inherit symlinkJoinName;
  pluginsList = envAttrsToExtend.pluginsList ++ plugins;
}

