-module(world).
-export([start/1, loop/3]).

start(Filename) ->
  spawn(world, loop, [read(Filename), 11, 13]).

loop(MapData, Row, Col) ->
  receive 
    {Caller, MsgID, snapshot} ->
      Caller ! { self(), MsgID, {snapshot, snapshot(MapData, Row, Col)}},
      loop(MapData, Row, Col);
    {Caller, MsgID, move_north} ->
      Caller ! { self(), MsgID, {move_north, Row-1, Col}},
      loop(MapData, Row-1, Col);
    {Caller, MsgID, move_south} ->
      Caller ! { self(), MsgID, {move_south, Row+1, Col}},
      loop(MapData, Row+1, Col);
    {Caller, MsgID, move_east} ->
      Caller ! { self(), MsgID, {move_east, Row, Col+1}},
      loop(MapData, Row, Col+1);
    {Caller, MsgID, move_west} ->
      Caller ! { self(), MsgID, {move_west, Row, Col-1}},
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
