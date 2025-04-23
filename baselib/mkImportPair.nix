{ pkgslib }: 
{ importInputs, filePath }:
{
  name = (import ./getSuffixlessBasename.nix { inherit pkgslib; }) filePath;
  value = import filePath importInputs;
}
