listOfLists:
  builtins.foldl' (acc: sublist: acc ++ sublist) [] listOfLists

