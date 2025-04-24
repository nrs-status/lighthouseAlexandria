{
  inputs = {
    nixvimFlake.url = "github:nix-community/nixvim";
  };

  outputs = inputs:
    rec {
      baselib = { pkgs }: import ./baselib { 
        pkgslib = pkgs.lib; 
        nixvimFlake = inputs.nixvimFlake;
      };
      tclib = { pkgs, typesSource }: import ./tclib {
        libs = {
          pkgslib = pkgs.lib;
          inherit baselib;
        };
        inherit typesSource;
      };
    };
}
