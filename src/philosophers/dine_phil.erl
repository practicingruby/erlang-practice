% Dining Philosophers setup.
%% By Luke Hoersten
%% Public Domain (PD) No Rights Reserved.

%% This is the Chandy / Misra Dining Philosophers Solution and it
%% assumes philosophers can talk to eachother.

-module(dine_phil).
-export([dine/1,sit/1]).

%%%% Setup
dine(Places) -> sit(Places).

%%%% Fork
pickup_fork(Clean) ->
    spawn(fun() -> fork(Clean) end).

fork(IsClean) ->
    receive
        {Phil, is_clean} ->
            Phil ! IsClean,
            fork(IsClean);
        set_dirty -> fork(false);
        set_clean -> fork(true)
    end.

%%%% Sit
sit(Num) -> %% first expects last as left
    First = spawn(fun() -> greet(last, pickup_fork(true)) end),
    sit(Num-1, First, First).

sit(1, Left, First) -> %% last expects first as right
    spawn(fun() -> greet(Left, First, pickup_fork(false)) end);
sit(Num, Left, First) ->
    Current = spawn(fun() -> greet(Left, pickup_fork(false)) end),
    sit(Num-1, Current, First).

%%%% Greet
greet(Left, First, Fork) ->
    First ! {last, self()}, %% last tells first when he's seated
    greet(Left, Fork).

greet(last, Fork) -> %% first waits for his right and last to sit
    receive
        {last, Last} -> greet(Last, Fork)
    end;
greet(Left, Fork) -> %% everyone tells left when he's seated
    Left ! {right, self()},
    receive
        {right, Right} -> eat(Left, Right, Fork)
    end.

