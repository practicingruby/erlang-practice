## December 26, 2013

**Total practice time: 30 minutes**

* Picked up a copy of "Programming Erlang, Second Edition" and browsed 
through it a bit.
* Added some checklists to CHECKLISTS.md

## December 27, 2013

**Total practice time: 60 minutes**

* Worked through the first two chapters of "Programming Erlang", typing in the
code examples as I went.

* Knocked several items off of the preliminaries checklist, many of which were
directly explained in CH2 of the book.

* Added new items to preliminaries checklist and made it a bit finer grained.

* Remembered the weird comma, semicolon, period syntax in Erlang, but still
don't know what each is used for. (Will need to learn that)

## January 1, 2014

**Total practice time: 90 minutes**

* While working on exercises, remembered what it's like to have helpful compile 
time errors (i.e. things like variable X is unused).

* Things like (-module, -export, ...) are annotations and not
expressions. This is why they can't be typed on the shell.

* Nice syntax for arbitrary based numbers, e.g. 16#beef and 2#1101101

* PE Ch3 spends lots of time talking about single assignment variables, a
concept I'm already familiar with from previous dabblings in Erlang, that
is somewhat controversial.

* Division in Erlang uses floats by default, to perform integer division it's
necessary to use the div and rem operators. Floats used internally will
have the same precision problems as in any other language.

* Atoms are the equivalent to Ruby's Symbols. Start with a lowercase letters,
followed by alphanumeric characters, underscore, and also allows @. Using single
quotes allows creation of arbitrary atoms.

* PE Ch3 covers usage of tuples, which are (very roughly) similar to structs,
but pattern matching can make extracting information from them more powerful. 
The underscore can be used as a catchall in pattern matching,
and is called an "anonymous variable". 

* PE Ch3 covers lists, which are used for arbitrarily long sets of ordered
data. Operating on the head of a list is very efficient. 

* PE Ch3 covers strings, and reminds that Erlang technically does not have a
string type. I had always thought this meant that it didn't understand
Unicode, but that's an incorrect assumption. However, it does require
special use of io:format to print non-ASCII chars, it seems.

* f() can be used to forget all defined variables in the shell, f(Term) to forget
an individual variable.

* Shell has tab expansion! Also lots of cool stuff under help().

* Order does matter in Lists, but not in Tuples. See below (based on a Ch3 exercise):

```erlang
48> Street = [ { house, {number, 43}, {name, "Mom"}}, { house, {number, 38}, {name, "Gramma"} ].
* 1: syntax error before: ']'
48> Street = [ { house, {number, 43}, {name, "Mom"}}, { house, {number, 38}, {name, "Gramma"}} ].
[{house,{number,43},{name,"Mom"}},
 {house,{number,38},{name,"Gramma"}}]
49> [ _, { house, { number, GrammaNumber}, _ }] = Street
49> .
[{house,{number,43},{name,"Mom"}},
 {house,{number,38},{name,"Gramma"}}]
50> GrammaNumber.
38
51> [{ house, { number, GrammaNumber}, _ }, _] = Street
51> .
** exception error: no match of right hand side value [{house,{number,43},{name,"Mom"}},
                                                       {house,{number,38},{name,"Gramma"}}]
```

## January 2, 2014

**Total practice time: 180 minutes**

* Attempted to get history working from previous sessions in erlang shell, but
did not succeed. However, did learn about `rlwrap` in the process, which seems
generally useful and gives Ctrl+R reverse lookup in `erl` (or anything!).

* Extraction by pattern matching is called *unpacking* in PE.

* Function clauses are separated by semicolons, each has a head and a body
separated by the arrow. The head is made up of a function name and patterns,
the body is made up of expressions.

* To write a very simple unit test, it is sufficient to use pattern matching
(as shown below), but PE recommends looking into the test frameworks
described in the Erlang docs.

```erlang
  test() ->
    12  = area({rectangle}, 3, 4),
    144 = area({square, 12}),
    tests_worked.
```

* I was reminded of how powerful pattern matching is for overloaded function
definitions -- this is something we lack in Ruby, and it leads to lots of
cumbersome looking argument processing.

* Decided my editor setup is good enough for now, which is plain vanilla 
Vim with syntax highlighting. May revisit this later when I build something
more interesting though.

* Turns out that the way to implement constant-like things in Erlang
is via macros, but they won't work on the shell. I was trying to extract
a PI constant in the area example. Unsure whether this is a practical 
limitation in erlang, or whether it is something that has an easy 
workaround / alternative. Within the scope of module definitions,
`define` / `include` work fine though. (NOTE: This was a diversion
not covered in PE Ch 4, just something I was curious about)

* My current understanding of Erlang's punctuation is that a period represents 
the end of a complete statement, the semicolons separate clauses, and comma
separate expressions. More-or-less the same thing is said here:
http://stackoverflow.com/a/14074747 -- I'm not 100% sure this is accurate
but it seems close enough and makes reading code a whole lot easier for me.
The last time I looked at Erlang I had no real conception of what
each of these punctuation marks did, which made writing code really painful.
PE describes the semantics as being similar to English, which kind of
makes sense.

* Possible common idiom in Erlang for doing summations:

```erlang
total([H|T]) -> some_function(H) + total(T);
total([]) -> 0.
```

* The concept of a Fun is equivalent to Ruby's procs, but with Erlang
function semantics (i.e. you can still do overloading via pattern matching).

* Erlang has common list functions like map, filter, etc.

* Erlang uses `=:=` as an equality test.

* Fun example of returning higher order functions:

```
43> MakeTest = fun(L) -> (fun(X) -> lists:member(X, L) end) end.
#Fun<erl_eval.6.80484245>
44> IsFruit = MakeTest(Fruit).
#Fun<erl_eval.6.80484245>
45> IsFruit(pear).
true
46> IsFruit(apple).
true
47> IsFruit(dog).
```

* The `import` statement allows calling certain functions from an 
external module directly. This is something I always miss in Ruby.

* Aside on pp59 of PE about how Joe programs is really nice, talking
about "growing" software rather than thinking it out up front, and
fast feedback loop between writing and tinkering.

* Erlang has list comprehensions, which I *love*. E.g.

```erlang
[2*X || X <- L].
[2,4,6,8,10]

[X || {a, X} <- [{a,1},{b,2},{c,3},{a,4},hello,"wow"]].
[1,4]

% this one melts my mind a bit.
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
```

* Have to think about what it's like to have lists rather than arrays as the
fundamental ordered collection -- this is a difference between Erlang and Ruby
and I'm unsure whether the performance differences cause practical issues
or are more theoretical in nature. For example, PE pp61 specifically talks
about things like infix append operator (`++`) being inefficient. Supposed
to be covered more in pp70.

* Kind of neat that Erlang shell autotruncates large datasets:

```erlang
3> lib_misc:pythag(200).
[{3,4,5},
 {4,3,5},
 {5,12,13},
 {6,8,10},
 {7,24,25},
 {8,6,10},
 {8,15,17},
 {9,12,15},
 {9,40,41},
 {10,24,26},
 {11,60,61},
 {12,5,13},
 {12,9,15},
 {12,16,20},
 {12,35,37},
 {13,84,85},
 {14,48,50},
 {15,8,17},
 {15,20,25},
 {15,36,39},
 {16,12,20},
 {16,30,34},
 {16,63,65},
 {18,24,30},
 {18,80,82},
 {20,15,25},
 {20,21,...},
 {20,...},
 {...}|...]
```

* Built-in-functions (BIFs) are used for things that can't be implemented
in Erlang, would be very inefficient to do so, or need to interact with
the OS. All of them are used as if they were on the module erlang, but
many are autoimported for direct use. Not all BIFs are described in PE
book, but they're listed on Erlang's man page and online.

* Guards are another thing I wish we had in Ruby, they do some prefiltering
on arguments and enhance pattern matching. When guards are used in expressions
rather than at the head of functions, they evaluate to true or false. Lots of
details about guard semantics starting on pp64-65. I remember this
being a somewhat complex feature of Erlang.

## January 3, 2013

**Total practice time: 75 minutes**

* Guards are limited to a subset of Erlang expressions, and user-defined functions
cannot be called from them. This is to ensure that guards remain side-effect
free and will always terminate.

* In guard expressions, semicolon means OR, and comma means AND.

* andalso/orelse do short circuit boolean evaluation, and/or evaluates 
  both sides.

* Like Ruby, Erlang has a very powerful case statement; it 
uses guards + patterns.

* In erlang leaving out a catchall case in an if expression will result
in an exception being raised. This is where a `true -> ...` guard comes
in handy.

* Rules for natural list building are on PE pp70, but previous examples (except
for the quick sort one) didn't have the described problem. The rules are basically 
that you should always append to the head of a list, and if this results in your
list being built backwards, then you can use `lists:reverse` to very efficiently swap
the order. In other words, most uses of `++` can be avoided, at the
occasional cost of clarity. The `odds_and_evens` example on pp71 shows lists
that need to be reversed.

* Accumulator on pp71 is an example of how to avoid processing a list multiple
times, which is something I always seem to ignore in Ruby, but always show
up in functional programming tutorials. For whatever reason, the concept
of accumulators always seems pedantic and awkward to me, but I suppose it
is useful to know the technique when optimization is needed.

* With recursion being the main way of doing everything in Erlang, it does
get tedious to define a trivial base case for each function, but I suppose it
does make it easy to see what the final return type will be.

* When pattern matching, `5.0 = 5` fails, and `5.0 =:= 5` evaluates as `false`.
What's the correct way to compare floats and ints by value?
