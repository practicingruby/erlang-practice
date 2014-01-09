-module(chopstick).
-export([start/1, loop/2]).

start(Number) ->
  spawn(chopstick, loop, [Number, nobody]).

loop(Number, Owner) ->
  receive
    {take, Owner} -> loop(Number, Owner);
    {take, NewOwner} when Owner =:= nobody -> 
      NewOwner ! {cs, Number},
      loop(Number, NewOwner);
    {drop, Owner} ->
      loop(Number, nobody)
  end.
