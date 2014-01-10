-module(world).
-export([read/1, snapshot/3]).

read(Filename) ->
  { ok, MapBinary } = file:read_file(Filename),
  MapText = binary_to_list(MapBinary),
  list_to_tuple(
    [ list_to_tuple(string:tokens(X, " ")) || 
      X <- string:tokens(MapText, "\n")]).
 
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

  
