-module(lib_misc).
-export([for/3, qsort/1, pythag/1, perms/1, max/2]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F)   -> [F(I) | for(I+1, Max, F)].

% example of guards
max(X,Y) when X > Y -> X;
max(_,Y) -> Y.

qsort([]) -> [];
qsort([Pivot|T]) ->
  qsort([X || X <- T, X < Pivot])
  ++ [Pivot] ++ % infix operator is an inefficient list operation
  qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
  [ {A,B,C} ||
    A <- lists:seq(1, N),
    B <- lists:seq(1, N),
    C <- lists:seq(1, N),
    A+B+C =< N,
    A*A+B*B =:= C*C
  ].


perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
