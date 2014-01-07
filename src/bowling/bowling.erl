-module(bowling).
-export([score/1, test/0]).

test() -> 
  9  = score([{7, 2}]), 

  %            4     6     8     9     5     0     3     1     0     4
  40 = score([{1,3},{2,4},{3,5},{5,4},{2,3},{0,0},{1,2},{1,0},{0,0},{1,3}]),

  %            4     6     8     S:12  5     0     3     1     0     4
  43 = score([{1,3},{2,4},{3,5},{5,5},{2,3},{0,0},{1,2},{1,0},{0,0},{1,3}]),

  %            4     6     8     S:15 5     0     3     1     0     4
  46 = score([{1,3},{2,4},{3,5},{10},{2,3},{0,0},{1,2},{1,0},{0,0},{1,3}]),

  %            4     6     8     S:14  S:11  1     3     1     0     4
  52 = score([{1,3},{2,4},{3,5},{5,5},{4,6},{1,0},{1,2},{1,0},{0,0},{1,3}]),

  %            4     6     8    S:21 S:13    3   3     1     0     4
  63 = score([{1,3},{2,4},{3,5},{10},{10},{1,2},{1,2},{1,0},{0,0},{1,3}]),

  300 = score([{10},{10},{10},{10},{10},{10},{10},{10},{10},{10},{10},{10}]),

  ok.

score([]) -> 0;
score([H|T]) -> 
  case H of
    {A} ->

      [H1|T1] = T,

      case H1 of
        { B, C } -> A + B + C + score(T);
        { B } -> 
          case T1 of
            []    -> 0;
            _ ->
              [H2|T2] = T1,
              case H2 of
                { C, _ } -> A + B + C + score(T);
                { C }    -> A + B + C + score(T)
              end
          end
      end;

    {A, B} when 10 =:= A + B ->
      { C, _ } = hd(T),

      A + B + C + score(T);

    {A, B} -> H, A + B + score(T)
  end.
