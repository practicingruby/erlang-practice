-module(ping_pong).
-export([start/1, loop/1]).

start(N) -> 
  Ping = spawn(ping_pong, loop, [ping]),
  Pong = spawn(ping_pong, loop, [pong]),

  Ping ! { Pong, N },
  done.

loop(Message) ->
  receive
    {Client, N} ->
      io:format("[~p] ~p Received: ~s ~n", [N, self(), Message]),

      case N of
        1 -> done;
        2 -> Client ! { self(), N - 1 }, done;
        _ -> Client ! { self(), N - 1 }, loop(Message)
      end
  end.
