{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
  };

  outputs = inputs:
    {
      lib = (import ./lib);
    };
}
