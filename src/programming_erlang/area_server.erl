-module(area_server).
-export([start/0, area/2, loop/0]).

start() ->
  spawn(area_server, loop, []).

area(Pid, What) -> rpc(Pid, What).

rpc(Pid, Request) ->
  Pid ! { self(), Request },
  receive
    {Pid, Response} -> Response
  end.

loop() ->
  receive
    {From, {rectangle, Width, Ht}} ->
      From ! {self(), Width * Ht};
    {From, {square, Side}} ->
      From ! {self(), Side * Side};
    {From, {circle, R}} ->
      From ! {self(), 3.14159 * R * R};
    {From, Other} ->
      From ! {self(), {error, Other}}
  end,
  loop().
