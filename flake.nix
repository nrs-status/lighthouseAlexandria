{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    nixvimFlake.url = "github:nix-community/nixvim";
  };

  outputs = inputs:
    let pkgs = import inputs.nixpkgs { system = "x86_64-linux"; }; in
    {
      pkgslib = pkgs.lib;
      baselib = import ./baselib { 
        pkgslib = pkgs.lib; 
        nixvimFlake = inputs.nixvimFlake;
      };
      inherit pkgs;
    };
}
