arg:
  let
  isWellFormed = builtins.attrNames arg == ["fields" "predicates"];
in
if !isWellFormed then
    abort "attrs subtype declaration not well formed; lacking either field 'fields' or field 'predicates'"
else if (builtins.length (arg.fields ++ arg.predicates) == 0) then
  abort "attrs subtype declaration is empty"
else {
  declType = "attrsSubtype";
  fields = arg.fields;
  predicates = arg.predicates;
}
