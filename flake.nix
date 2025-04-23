{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    let pkgs = import inputs.nixpkgs {}; in
    {
      pkgslib = pkgs.lib;
      baselib = import ./baselib { pkgslib = pkgs.lib; };
    };
}
