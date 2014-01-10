-module(trivial_process).
-export([start/0, loop/1]).

start() -> spawn(?MODULE, loop, [1]).

loop(N) ->
  io:format("Tick ~p.~n", [N]),

  receive
    _ -> error("Boom!")
  after 1000 ->
    loop(N+1)
  end.
