-module(chopstick).
-export([start/1, loop/2]).

start(Number) ->
  spawn(chopstick, loop, [Number, nobody]).

% TODO: Consider using a stateful module?

loop(Number, Owner) ->
  receive
    {take, Owner} -> loop(Number, Owner);
    {take, NewOwner} when Owner =:= nobody -> 
      io:format("~p picked up chopstick ~p~n", [NewOwner, Number]),
      loop(Number, NewOwner);
    {drop, Owner} ->
      io:format("~p put down chopstick ~p~n", [Owner, Number]),
      loop(Number, nobody)
  end.
