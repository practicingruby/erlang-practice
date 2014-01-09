-module(philosophers).
-export([dine/0, loop/3]).

dine() ->
  [C1, C2, C3, C4, C5] = [chopstick:start(X) || X <- [1,2,3,4,5]],
  dine(C1, C2, C3, C4, C5).


dine(C1, C2, C3, C4, C5) -> 
  Aristotle    = spawn(philosophers, loop, ["Aristotle",    C1, C2]),
  Popper       = spawn(philosophers, loop, ["Popper",       C2, C3]),
  Epictetus    = spawn(philosophers, loop, ["Epictetus",    C3, C4]),
  Heraclitus   = spawn(philosophers, loop, ["Heraclitus",   C4, C5]),
  Schopenhauer = spawn(philosophers, loop, ["Schopenhauer", C1, C5]),

  Aristotle ! Popper ! Epictetus ! Heraclitus ! Schopenhauer ! think.

loop(Philosopher, LeftChopstick, RightChopstick) ->
  receive
    think -> 
      io:format("~p is thinking.~n", [Philosopher]),
      timer:sleep(1000),

      self() ! eat;
    eat   -> 
      LeftChopstick  ! {take, self()},

      receive
        {cs, FirstChopstick} ->
          io:format("~p picked up chopstick ~p~n", [Philosopher, FirstChopstick]), 

          RightChopstick ! {take, self()},
          receive
            {cs, SecondChopstick} ->
              io:format("~p picked up chopstick ~p~n", [Philosopher, SecondChopstick]),
              io:format("~p is eating.~n", [Philosopher]),
              timer:sleep(1000)
          end
      end,

      LeftChopstick  ! {drop, self()},
      RightChopstick ! {drop, self()},

      io:format("~p is done eating, releases chopsticks ~p and ~p~n",
        [Philosopher, FirstChopstick, SecondChopstick]),

      self() ! think
  end,

  loop(Philosopher, LeftChopstick, RightChopstick).
