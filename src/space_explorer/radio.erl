-module(radio).
-export([start/1, loop/1]).
-define(TRANSMISSION_DELAY, 5000).

start(Controller) -> spawn(radio, loop, [Controller]).

loop(Controller) ->
  receive
    { transmit, Pid, Message } ->
      erlang:send_after(?TRANSMISSION_DELAY, Pid, {self(), erlang:make_ref(), Message});
    Message ->
      erlang:send_after(?TRANSMISSION_DELAY, Controller, Message)
  end,

  loop(Controller).
