-module(exercises).
-export([minimum/1]).

minimum([H|T]) -> minimum(T, H).

minimum([],    Smallest) -> Smallest;
minimum([H|T], Smallest) -> 
  case Smallest < H of
    true  -> minimum(T, Smallest);
    false -> minimum(T, H)
  end.
