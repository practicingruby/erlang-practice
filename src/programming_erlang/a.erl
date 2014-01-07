-module(a).
-compile(export_all).
-define(TIMEOUT, 3000).

start(Tag) ->
  spawn(fun() -> loop(Tag) end).

loop(Tag) ->
  sleep(),
  Val = b:x(),
  io:format("Vsn3 (~p) b:x() = ~p~n", [Tag, Val]),
  loop(Tag).

sleep() ->
  receive
    after ?TIMEOUT -> true
  end.
