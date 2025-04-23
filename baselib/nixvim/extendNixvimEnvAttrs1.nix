{ envAttrsToExtend, symlinkJoinName, plugins }:
envAttrsToExtend // {
  inherit symlinkJoinName;
  plugins = envAttrsToExtend ++ plugins;
}

