-module(mylists).
-export([sum/1, map/2, filter/2]).

sum([H|T]) -> H + sum(T);
sum([])    -> 0.

map(F, L) -> [F(X) || X <- L].

filter(F, [H|T]) ->
  case F(H) of
    true  -> [H | filter(F, T)];
    false -> filter(F, T)
  end;

filter(_, []) -> [].
