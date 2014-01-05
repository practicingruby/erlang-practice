-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
  receive
    {Client, list_dir} ->
      Client ! {self(), file:list_dir(Dir)};
    {Client, {get_file, File}} ->
      Full = filename:join(Dir, File),
      Client ! {self(), file:read_file(Full)};
    {Client, {put_file, File, Contents}} ->
      Full = filename:join(Dir, File),
      Client ! {self(), file:write_file(Full, Contents)}
  end,
  loop(Dir).
