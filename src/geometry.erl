-module(geometry).
-export([test/0, area/1]).
-define(PI, 3.14159).

test() ->
  12  = area({rectangle, 3, 4}),
  144 = area({square, 12}),
  4 * ?PI = area({circle, 2}),
  tests_worked.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side;
area({circle, Radius})           -> ?PI * Radius * Radius.
