{ pkgslib }: 
{ importInputs, filePath }:
{
  name = (import ./getSuffixlessBasename { inherit pkgslib; });
  value = import filePath importInputs;
}
