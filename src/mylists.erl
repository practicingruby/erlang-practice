-module(mylists).
-export([sum/1, map/2]).

sum([H|T]) -> H + sum(T);
sum([])    -> 0.

map(F, L) -> [F(X) || X <- L].
