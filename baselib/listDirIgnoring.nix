{ pkgslib }:
{ignore, dir }:
let
  trueIfIsNixFileButNotInIgnoreList = ( filePath:
    pkgslib.hasSuffix ".nix" filePath
    && ! ( builtins.elem filePath ignore )
  );
in
pkgslib.filter trueIfIsNixFileButNotInIgnoreList ( pkgslib.filesystem.listFilesRecursive dir )
