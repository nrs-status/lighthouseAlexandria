{ pkgslib }:
let f = val: checkee: if pkgslib.isDerivation val then
  builtins.elem val checkee
else if builtins.isAttrs val then
  builtins.mapAttrs (key: val': f val' checkee) val
else
  builtins.elem val checkee;
in f
