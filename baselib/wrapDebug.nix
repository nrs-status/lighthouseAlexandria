{ total, activateDebug ? false}:
(import ./withDebug.nix) activateDebug {
  debug = total;
  nondebug = total.final;
}
