-module(lib_misc).
-export([for/3, qsort/1, pythag/1, perms/1, 
         max/2, odds_and_evens/1, my_tuple_to_list/1,
         my_time_func/1, my_date_func/0, sqrt/1, my_file_read/1]).

for(Max, Max, F) -> [F(Max)];
for(I, Max, F)   -> [F(I) | for(I+1, Max, F)].


my_file_read(File) ->
  case file:read_file(File) of
    {ok, Bin} -> Bin;
    {error, Reason} -> error({"Couldn't read file", Reason})
  end.


sqrt(X) when X < 0 ->
  error({squareRootNegativeArgument, X});
sqrt(X) ->
  math:sqrt(X).

my_tuple_to_list({}) -> [];
my_tuple_to_list(T) -> 
  [erlang:element(1, T) | my_tuple_to_list(erlang:delete_element(1, T))].

my_time_func(F) ->
  {MegaS@T1, S@T1, MicroS@T1 } = erlang:now(),
  F(),
  {MegaS@T2, S@T2, MicroS@T2 } = erlang:now(),

  (MegaS@T2 - MegaS@T1)*1000000 + (S@T2 - S@T1) + (MicroS@T2 - MicroS@T1)/1000000.

my_date_func() ->
  {Year, Month, Day}       = erlang:date(),
  {Hour, Minutes, Seconds} = erlang:time(),

  io:format("~B-~B-~B ~B:~B:~B~n", [Year, Month, Day, Hour, Minutes, Seconds]).


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

%odds_and_evens(L) ->
%  { [X || X <- L, X rem 2 =:= 1],
%    [X || X <- L, X rem 2 =:= 0] }.

odds_and_evens(L) ->
  odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
  case H rem 2 of
    0 -> odds_and_evens_acc(T, Odds, [H|Evens]);
    1 -> odds_and_evens_acc(T, [H|Odds], Evens)
  end;

odds_and_evens_acc([], Odds, Evens) ->
  {lists:reverse(Odds), lists:reverse(Evens)}. 
