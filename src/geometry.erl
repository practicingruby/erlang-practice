-module(geometry).
-export([test/0, area/1, hypot/2, perimeter/1]).
-define(PI, 3.14159).

test() ->
  12  = area({rectangle, 3, 4}),
  144 = area({square, 12}),
  4 * ?PI = area({circle, 2}),
  
  5.0 = hypot(3,4),


  tests_worked.

hypot(A, B) -> math:sqrt(A*A + B*B).

area({rectangle, Width, Height})      -> Width * Height;
area({square, Side})                  -> Side * Side;
area({circle, Radius})                -> ?PI * Radius * Radius;
area({right_triangle, Base, Height})  -> (Base * Height) / 2.

perimeter({rectangle, Width, Height})     -> 2 * Width + 2 * Height;
perimeter({square, Side})                 -> 4 * Side;
perimeter({circle, Radius})               -> 2 * ?PI * Radius;
perimeter({right_triangle, Base, Height}) -> 
  Base + Height + hypot(Base, Height).
