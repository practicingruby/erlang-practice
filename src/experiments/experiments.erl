-module(experiments).
-import(lists, [map/2]).
-export([demo/0]).

demo() -> map(fun(X) -> X + 1 end, [1,2,3]).
map(F,L) -> {F, L}. 
