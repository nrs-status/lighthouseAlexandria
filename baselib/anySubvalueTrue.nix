let f = val: if builtins.isAttrs val then
  builtins.foldl' (acc: next: acc || next) true (builtins.attrValues (builtins.mapAttrs (key: val': f val') val))
  else val == true;
in f
