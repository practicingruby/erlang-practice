-module(waiter).
-export([start/0, loop/0]).

start() -> spawn(waiter, loop, []).

loop() -> 
  receive
    {service_requested, Philosopher} -> 
      Philosopher ! eat;
    {service_finished, Philosopher}  -> 
      Philosopher ! think
  end.
