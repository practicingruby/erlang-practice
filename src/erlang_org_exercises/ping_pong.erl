-module(ping_pong).
-export([start/1, loop/1]).

start(Message) -> spawn(ping_pong, loop, [Message]).

loop(Message) ->
  receive
    {Client, N} ->
      io:format("~p Received: ~s~n", [self(), Message]),

      %% FIXME: Find out why this isn't working! %%
      case N of
        1    -> Client ! { self(), N -1 }, exit(self(), ok);
        0    -> exit(self(), ok);
        true -> Client ! { self(), N - 1 }
      end
  end,
  loop(Message).
