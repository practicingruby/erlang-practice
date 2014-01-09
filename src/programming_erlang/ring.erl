-module(ring).
-export([send/2, loop/1]).

send(N, M) ->
  Head = build(N),
  Head ! { deliver, howdy, N*M }.

start() ->
  spawn(ring, loop, [void]).

connect(From, To) ->
  From ! {observe, To}.

build(N) ->
  First = start(),
  Last  = build(N-1, First),

  connect(Last, First),
  First.

build(0, Current) -> Current;

build(N, Current) ->
  Next = start(),
  connect(Current, Next),
  build(N-1, Next).

loop(Observer) ->
  receive
    {observe, NewObserver} -> 
      io:format("~p is now observing ~p", [self(), NewObserver]),
      loop(NewObserver);
    {deliver, _, 0} ->
      io:format("Done sending messages!~n"),
      loop(Observer);
    {deliver, Message, Count} when Observer =/= void ->
      io:format("[~p], ~p is sending message ~p to ~p~n", 
        [Count, self(), Message, Observer]),
      Observer ! {deliver, Message, Count - 1},
      loop(Observer)
  end.
