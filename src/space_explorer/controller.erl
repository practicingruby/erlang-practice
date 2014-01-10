-module(controller).
-export([start/0, loop/0]).

start() -> spawn(controller, loop, []).

loop() ->
  receive
    {_, MsgId, {snapshot, MapData} } ->
      io:format("~s~n~n(msg id: ~p)~n", [MapData, MsgId]);
    Any -> io:format("Received message: ~p~n", [Any])
  end,
  loop().
