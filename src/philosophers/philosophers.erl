-module(philosophers).
-export([dine/5, loop/3]).

dine(C1, C2, C3, C4, C5) -> 
  Aristotle    = spawn(philosophers, loop, ["Aristotle", C1, C2]),
  Popper       = spawn(philosophers, loop, ["Popper", C2, C3]),
  Epictetus    = spawn(philosophers, loop, ["Epictetus", C3, C4]),
  Heraclitus   = spawn(philosophers, loop, ["Heraclitus", C4, C5]),
  Schopenhauer = spawn(philosophers, loop, ["Schopenhauer", C5, C1]),

  Aristotle ! Popper ! Epictetus ! Heraclitus ! Schopenhauer ! think,
  Aristotle ! Popper ! Epictetus ! Heraclitus ! Schopenhauer ! eat.

% FIXME: The loop below isn't close to being function,
% it's just a rough starting point.

loop(Philosopher, LeftChopstick, RightChopstick) ->
  receive
    think -> 
      io:format("~p is thinking.~n", [Philosopher]);
    eat   -> 
      LeftChopstick  ! {take, Philosopher},
      RightChopstick ! {take, Philosopher},

      % need to verify that philosopher has both chopsticks before this happens.

      LeftChopstick  ! {drop, Philosopher},
      RightChopstick ! {drop, Philosopher}
  end,
  loop(Philosopher, LeftChopstick, RightChopstick).



