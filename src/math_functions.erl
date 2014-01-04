-module(math_functions).
-export([even/1, odd/1, filter/2, split1/1, split2/1]).

even(X) -> X rem 2 =:= 0.
odd(X)  -> X rem 2 =:= 1.

filter(F, L)  -> [X || X <- L, F(X)].

split1(L) -> { filter(fun(X) -> even(X) end, L), 
               filter(fun(X) -> odd(X) end, L) }.

split2(L) -> { split_acc(L, [], []) }.

split_acc([H|L], Evens, Odds) ->
  case even(H) of
    true  -> split_acc(L, [H|Evens], Odds);
    false -> split_acc(L, Evens, [H|Odds])
  end;
  
split_acc(_, Evens, Odds) ->
  { lists:reverse(Evens), lists:reverse(Odds) }.
