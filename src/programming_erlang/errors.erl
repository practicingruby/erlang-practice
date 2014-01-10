-module(errors).
-export([my_spawn/3]).

my_spawn(Mod, Func, Args) ->
  Pid = spawn(Mod, Func, Args),
  {T1, _} = statistics(wall_clock),

  spawn(fun() ->
    Ref = monitor(process, Pid),
    receive
      { 'DOWN', Ref, process, Pid, Why } ->
        io:format("~p went down with reason: ~p~n", [Pid, Why]),

        {T2, _} = statistics(wall_clock),

        io:format("~p was alive for ~p seconds~n", [Pid, (T2-T1)/1000])
    end
  end),

  Pid.
