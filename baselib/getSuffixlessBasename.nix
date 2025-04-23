{ pkgslib }:
filePath: pkgslib.removeSuffix ".nix" (baseNameOf filePath)
