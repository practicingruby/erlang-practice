-module(world).
-export([start/1, loop/3, rpc/2]).

start(Filename) ->
  spawn(world, loop, [read(Filename), 11, 13]).

rpc(Pid, Request) ->
  Pid ! { self(), Request },
  receive
    {Pid, Response} -> Response
  end.

loop(MapData, Row, Col) ->
  receive 
    {Caller, snapshot} ->
      Caller ! { self(), {snapshot, snapshot(MapData, Row, Col)}},
      loop(MapData, Row, Col);
    {Caller, move_north} ->
      Caller ! { self(), {move_north, Row-1, Col}},
      loop(MapData, Row-1, Col);
    {Caller, move_south} ->
      Caller ! { self(), {move_south, Row+1, Col}},
      loop(MapData, Row+1, Col);
    {Caller, move_east} ->
      Caller ! { self(), {move_east, Row, Col+1}},
      loop(MapData, Row, Col+1);
    {Caller, move_west} ->
      Caller ! { self(), {move_west, Row, Col-1}},
      loop(MapData, Row, Col-1)
  end.


read(Filename) ->
  { ok, MapBinary } = file:read_file(Filename),
  MapText = binary_to_list(MapBinary),
  list_to_tuple(
    [ list_to_tuple(string:tokens(X, " ")) || 
      X <- string:tokens(MapText, "\n")]).

% TODO: add @ sign to indicate current location.
snapshot(Map, Row, Col) ->
  RowWindow = [ element(RowD, Map) || 
                RowD <- lists:seq(Row - 2, Row + 2) ],

  string:join(
    lists:map(fun(RowData) ->
      string:join(
        [element(ColD, RowData) || ColD <- lists:seq(Col - 2, Col + 2)], 
        " ")
      end, 
      RowWindow), 
     "\n") ++ "\n".
