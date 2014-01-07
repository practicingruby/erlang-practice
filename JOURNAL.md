## December 26, 2013

**Total practice time: 30 minutes**

Picked up a copy of "Programming Erlang, Second Edition" and browsed 
through it a bit.

-------------------------------------------------------------------------------

Added some checklists to CHECKLISTS.md

## December 27, 2013

**Total practice time: 60 minutes**

Worked through the first two chapters of "Programming Erlang", typing in the
code examples as I went.

-------------------------------------------------------------------------------

Knocked several items off of the preliminaries checklist, many of which were
directly explained in CH2 of the book.

-------------------------------------------------------------------------------

Added new items to preliminaries checklist and made it a bit finer grained.

-------------------------------------------------------------------------------

Remembered the weird comma, semicolon, period syntax in Erlang, but still
don't know what each is used for. (Will need to learn that)

## January 1, 2014

**Total practice time: 90 minutes**

While working on exercises, remembered what it's like to have helpful compile 
time errors (i.e. things like variable X is unused).

-------------------------------------------------------------------------------

Things like (-module, -export, ...) are annotations and not
expressions. This is why they can't be typed on the shell.

-------------------------------------------------------------------------------

Nice syntax for arbitrary based numbers, e.g. 16#beef and 2#1101101

-------------------------------------------------------------------------------

PE Ch3 spends lots of time talking about single assignment variables, a
concept I'm already familiar with from previous dabblings in Erlang, that
is somewhat controversial.

-------------------------------------------------------------------------------

Division in Erlang uses floats by default, to perform integer division it's
necessary to use the div and rem operators. Floats used internally will
have the same precision problems as in any other language.

-------------------------------------------------------------------------------

Atoms are the equivalent to Ruby's Symbols. Start with a lowercase letters,
followed by alphanumeric characters, underscore, and also allows @. Using single
quotes allows creation of arbitrary atoms.

-------------------------------------------------------------------------------

PE Ch3 covers usage of tuples, which are (very roughly) similar to structs,
but pattern matching can make extracting information from them more powerful. 
The underscore can be used as a catchall in pattern matching,
and is called an "anonymous variable". 

-------------------------------------------------------------------------------

PE Ch3 covers lists, which are used for arbitrarily long sets of ordered
data. Operating on the head of a list is very efficient. 

-------------------------------------------------------------------------------

PE Ch3 covers strings, and reminds that Erlang technically does not have a
string type. I had always thought this meant that it didn't understand
Unicode, but that's an incorrect assumption. However, it does require
special use of io:format to print non-ASCII chars, it seems.

-------------------------------------------------------------------------------

f() can be used to forget all defined variables in the shell, f(Term) to forget
an individual variable.

-------------------------------------------------------------------------------

Shell has tab expansion! Also lots of cool stuff under help().

-------------------------------------------------------------------------------

Order does matter in Lists, but not in Tuples. See below (based on a Ch3 exercise):

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

Attempted to get history working from previous sessions in erlang shell, but
did not succeed. However, did learn about `rlwrap` in the process, which seems
generally useful and gives Ctrl+R reverse lookup in `erl` (or anything!).

-------------------------------------------------------------------------------

Extraction by pattern matching is called *unpacking* in PE.

-------------------------------------------------------------------------------

Function clauses are separated by semicolons, each has a head and a body
separated by the arrow. The head is made up of a function name and patterns,
the body is made up of expressions.

-------------------------------------------------------------------------------

To write a very simple unit test, it is sufficient to use pattern matching
(as shown below), but PE recommends looking into the test frameworks
described in the Erlang docs.

```erlang
test() ->
  12  = area({rectangle}, 3, 4),
  144 = area({square, 12}),
  tests_worked.
```

-------------------------------------------------------------------------------

I was reminded of how powerful pattern matching is for overloaded function
definitions -- this is something we lack in Ruby, and it leads to lots of
cumbersome looking argument processing.

-------------------------------------------------------------------------------

Decided my editor setup is good enough for now, which is plain vanilla 
Vim with syntax highlighting. May revisit this later when I build something
more interesting though.

-------------------------------------------------------------------------------

Turns out that the way to implement constant-like things in Erlang
is via macros, but they won't work on the shell. I was trying to extract
a PI constant in the area example. Unsure whether this is a practical 
limitation in erlang, or whether it is something that has an easy 
workaround / alternative. Within the scope of module definitions,
`define` / `include` work fine though. (NOTE: This was a diversion
not covered in PE Ch 4, just something I was curious about)

-------------------------------------------------------------------------------

My current understanding of Erlang's punctuation is that a period represents 
the end of a complete statement, the semicolons separate clauses, and comma
separate expressions. More-or-less the same thing is said here:
http://stackoverflow.com/a/14074747 -- I'm not 100% sure this is accurate
but it seems close enough and makes reading code a whole lot easier for me.
The last time I looked at Erlang I had no real conception of what
each of these punctuation marks did, which made writing code really painful.
PE describes the semantics as being similar to English, which kind of
makes sense.

-------------------------------------------------------------------------------

Possible common idiom in Erlang for doing summations:

```erlang
total([H|T]) -> some_function(H) + total(T);
total([]) -> 0.
```

UPDATE: No. Use `lists:sum` instead.

-------------------------------------------------------------------------------

The concept of a Fun is equivalent to Ruby's procs, but with Erlang
function semantics (i.e. you can still do overloading via pattern matching).

-------------------------------------------------------------------------------

Erlang has common list functions like map, filter, etc.

-------------------------------------------------------------------------------

Erlang uses `=:=` as an equality test.

-------------------------------------------------------------------------------

Fun example of returning higher order functions:

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

-------------------------------------------------------------------------------

The `import` statement allows calling certain functions from an 
external module directly. This is something I always miss in Ruby.

-------------------------------------------------------------------------------

Aside on pp59 of PE about how Joe programs is really nice, talking
about "growing" software rather than thinking it out up front, and
fast feedback loop between writing and tinkering.

-------------------------------------------------------------------------------

Erlang has list comprehensions, which I *love*. E.g.

```erlang
[2*X || X <- L].
[2,4,6,8,10]

[X || {a, X} <- [{a,1},{b,2},{c,3},{a,4},hello,"wow"]].
[1,4]

% this one melts my mind a bit.
perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L--[H])].
```

-------------------------------------------------------------------------------

Have to think about what it's like to have lists rather than arrays as the
fundamental ordered collection -- this is a difference between Erlang and Ruby
and I'm unsure whether the performance differences cause practical issues
or are more theoretical in nature. For example, PE pp61 specifically talks
about things like infix append operator (`++`) being inefficient. Supposed
to be covered more in pp70.

-------------------------------------------------------------------------------

Kind of neat that Erlang shell autotruncates large datasets:

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

-------------------------------------------------------------------------------

Built-in-functions (BIFs) are used for things that can't be implemented
in Erlang, would be very inefficient to do so, or need to interact with
the OS. All of them are used as if they were on the module erlang, but
many are autoimported for direct use. Not all BIFs are described in PE
book, but they're listed on Erlang's man page and online.

-------------------------------------------------------------------------------

Guards are another thing I wish we had in Ruby, they do some prefiltering
on arguments and enhance pattern matching. When guards are used in expressions
rather than at the head of functions, they evaluate to true or false. Lots of
details about guard semantics starting on pp64-65. I remember this
being a somewhat complex feature of Erlang.

## January 3, 2014

**Total practice time: 180 minutes**

Guards are limited to a subset of Erlang expressions, and user-defined functions
cannot be called from them. This is to ensure that guards remain side-effect
free and will always terminate.

-------------------------------------------------------------------------------

In guard expressions, semicolon means OR, and comma means AND.

-------------------------------------------------------------------------------

andalso/orelse do short circuit boolean evaluation, and/or evaluates 
both sides.

-------------------------------------------------------------------------------

Like Ruby, Erlang has a very powerful case statement; it 
uses guards + patterns.

-------------------------------------------------------------------------------

In erlang leaving out a catchall case in an if expression will result
in an exception being raised. This is where a `true -> ...` guard comes
in handy.

-------------------------------------------------------------------------------

Rules for natural list building are on PE pp70, but previous examples (except
for the quick sort one) didn't have the described problem. The rules are basically 
that you should always append to the head of a list, and if this results in your
list being built backwards, then you can use `lists:reverse` to very efficiently swap
the order. In other words, most uses of `++` can be avoided, at the
occasional cost of clarity. The `odds_and_evens` example on pp71 shows lists
that need to be reversed.

-------------------------------------------------------------------------------

Accumulator on pp71 is an example of how to avoid processing a list multiple
times, which is something I always seem to ignore in Ruby, but always show
up in functional programming tutorials. For whatever reason, the concept
of accumulators always seems pedantic and awkward to me, but I suppose it
is useful to know the technique when optimization is needed.

-------------------------------------------------------------------------------

With recursion being the main way of doing everything in Erlang, it does
get tedious to define a trivial base case for each function, but I suppose it
does make it easy to see what the final return type will be.

-------------------------------------------------------------------------------

When pattern matching, `5.0 = 5` fails, and `5.0 =:= 5` evaluates as `false`.
What's the correct way to compare floats and ints by value?

-------------------------------------------------------------------------------

The erlang module is (very roughly) analogous to Ruby's kernel module... all
sorts of global utility functions.

-------------------------------------------------------------------------------

Working through the exercises at the end of PE Ch4 gave me a nice introduction
to lots of primitive erlang features, but also left me wondering whether what
their high level alternatives are. The cost of simplicity is that sometimes
"easy" tasks feel a bit more complicated than they need to be because you're
working with such bare constructs. Still, the appealing aspect is that
the code is definitely easier to reason about in the end. This is a design
aesthetic that I've been consistently split-minded about, whenever comparing
Ruby to functional languages or minimal scripting languages like Lua. One thing
I am curious about studying is to what extent these issues feel bothersome when
working on larger projects than what is typically covered in intro tutorials --
I don't have a good guess at that.

-------------------------------------------------------------------------------

I should probably find someone who knows Erlang fairly well to review my
Ch4 exercises, as I think there are probably better idioms than the ones I used.

## January 5, 2014

**Total Practice Time: 180 mins **

I had skimmed Ch6 on Jan 4, but didn't count it as reading the chapter because
I wasn't near a computer, nor did I reason through each example in detail. To
read properly is to attempt to implement what is described before seeing the
code when possible (even if it's just in your head), or to look at a piece of
code and explain it to yourself before reading the prose. It's not the same
as just listening to the author talk and looking at the code samples that
emerge from their head, you need to synthesize them into your own
thought process. 

-------------------------------------------------------------------------------

This bootstrapping process is what real reading looks like,
as compared to skimming. It needs to be a two way conversation, complete
with questions, tangents, and diversions along the way. It does not
however need a formal structure, unless you find that it helps.
At a minimum, you need to be able to write code or work out traces on
pencil and paper, as well as be able to write or type notes as you go
to be seriously reading, though.

-------------------------------------------------------------------------------

Topic for PE Ch5 is Records and Maps. Records are really just a way
of giving names to elements in a tuple, and are meant for a fixed number
elements that you have names for in advance. Their definitions need
to be provided in header files, and cannot be defined in the shell.

-------------------------------------------------------------------------------

I am reminded of the fact that immutable data structures do not necessarily
need to be awkward to manipulate. Personally I find Erlang's syntax for 
this very reasonable:

```erlang
1> X1 = #todo{status=urgent, text="Fix errata in book"}.
#todo{status = urgent,who = joe,text = "Fix errata in book"}
2> #todo{status = Who, text = Text } = X1.
#todo{status = urgent,who = joe,text = "Fix errata in book"}
3> Who.
urgent
4> Text.
"Fix errata in book"
4> X1#todo.text.
"Fix errata in book"
5> X1#todo.status.
urgent
6> X1#todo.who.
joe
7> X2 = X1#todo{status=done}.
#todo{status = done,who = joe,text = "Fix errata in book"}
```

-------------------------------------------------------------------------------

Erlang records are very close to my idea of what a "minimal struct" might
look like -- they're probably useful for wrapping arguments and results in
functions.

-------------------------------------------------------------------------------

Like everything else, extraction and pattern matching can be done in
function headings. This is a concept that is extremely powerful and
seems very consistent in Erlang, but I still haven't gotten in the 
habit of remembering it.

-------------------------------------------------------------------------------

I wonder if it possible to recast a record into a new record type. 
(could not easily google an answer for this, and it's probably a bad 
practice, but I'm just wondering how you build a new record in a 
different type from the data in another type).

-------------------------------------------------------------------------------

It looks like one of the main features of Erlang that I was interested in
learning about in the PE book (Maps) are not released in any public
version of Erlang yet, nor is there even source available to build it
from. I may be wrong about that, but if not it's a huge difference from
something like Ruby where at the very least all development is done
in the open. I understand future proofing the book but there should
at least have been a caveat mentioned somewhere that the feature
is currently vaporware. (UPDATE: LOOKS LIKE THERE'S A PRERELEASE!
http://erlang.org/pipermail/erlang-questions/2013-October/075752.html
-- @joeerl tweeted this to me)

-------------------------------------------------------------------------------

Studying the rest of Ch5 is unfortunately not that useful because
Maps are not released yet. Further study of Erlang's `dict` library
may be worthwhile if we really need functionality similar to a Ruby
hash, but it's API looks awkward at a glance:
http://www.techrepublic.com/article/working-with-dictionaries-in-erlang/ 
-- also should look at `proplists`.

-------------------------------------------------------------------------------

Pervasive pattern matching means defensive programming is built in to Erlang:
If you clearly specify the valid arguments and results from a function, all
invalid uses of your APIs will be caught automatically.

-------------------------------------------------------------------------------

Never return values from functions that are called with invalid APis, let them
crash! (They're not recoverable errors).

-------------------------------------------------------------------------------

-Erlang has three ways of explicit error generation: `exit`, `throw`, and `error`.
`exit` is a hard halt, which notifies all linked processes of the failure
and sends them a shutdown message. `throw` is for raising errors that could
concievably be caught and managed, `error` is for "crashing" failures
that the callers are not expected to handle.

-------------------------------------------------------------------------------

There are two ways of catching exceptions: `try/catch`, and plain `catch`.

-------------------------------------------------------------------------------

Using `try/catch`, you can use pattern matching (surprise surpise!) and guards
to detect and handle different kinds of exceptions.

-------------------------------------------------------------------------------

Using `catch` is lower level, and converts the error into a tuple directly. It
gives a lot of detail for `error`-raised exceptions, including a stack trace.

-------------------------------------------------------------------------------

Like using Ruby's `raise`, the Erlang `error` function gives an opportunity to
give more specific and helpful error messages upon failure. But in the case of
Erlang, the message is an arbitrary structure rather than an 
"exception object".

-------------------------------------------------------------------------------

An idiom for dealing with common error conditions is to either return `{ok,
Value}` or `{error, Reason}`, but this forces the caller to either use
a case statement to differentiate between the nominal and off-nominal
responses, or to use pattern matching and cause an exception to be raised.

-------------------------------------------------------------------------------

The `try/catch` approach is used for conditions where errors are possible
but rare, much like how we'd use `begin rescue end` in Ruby.

-------------------------------------------------------------------------------

A catchall exception handler can be written like this:

```erlang
try Expr
catch
_:_ -> ...
end
```
-------------------------------------------------------------------------------

Even when using `try/catch`, it's possible to get the latest stack trace via
`erlang:get_stacktrace()`. (note: there is a comment on pp96 I don't fully
understand about last-call optimization, but I think it's to produce
cleaner stack traces, particularly in recursive functions)

-------------------------------------------------------------------------------

Erlang's design aesthetic is fail fast and noisily with a meaningful error
 message, ideally logging to a permanent error log with enough information to
 facilitate debugging later. Failures should not bubble up to the end user,
 but the user should be notified that there was a problem. (NOTE: These seem
 more like general philosophical points than Erlang issues, but maybe
 we'll see more later in PE that show how Erlang facilitates this design
 style???)

## January 6, 2014

**Total Practice Time: 120 mins **

Should have prepared my exercises better, because the ones I found at erlang.org
are for the most part either similar to what I've already done in the PE book, 
or based on topics that I haven't studied yet. Still, I found the exercise for
implementing list:min() a good refresher on pattern matching / recursion style
of programming. Also began work on concurrent process interaction, based on
the single file server example and vague memories of past Erlang experiments.

-------------------------------------------------------------------------------

Saving all of your exercises from the past is extremely useful. To work on
the concurrent example, I looked at the file server exercise
(for process functions), as well as the very first hello world example
(io:format). Always use what you already have to learn something new!

-------------------------------------------------------------------------------

`io:format` takes a *list* rather than N arguments, I always forget this.

-------------------------------------------------------------------------------

Skipped over Ch 7 on Binaries/Bit Syntax because although it's a very cool
feature, I don't expect the projects I'm working on during this deliberate
practice will need them. I can always go back if necessary. (Also I've done a
little bit of experimentation with Erlang's bit syntax in the past).

-------------------------------------------------------------------------------

PE CH8 covers a grab bag of Erlang primitives in no particular order.

-------------------------------------------------------------------------------

pp116 has the arithmetic operations table, it's the usual stuff, along
with bitwise arithmetic, and integer division / remainder operations.

-------------------------------------------------------------------------------

Modules are conventionally named the same as their file. Without naming
them that way, autoload does not work correctly (though I haven't learned
about autoloading yet).

-------------------------------------------------------------------------------

Import allows you to call functions from other modules without providing their
fully qualified name. It's worth noting that if your module defines
the same function name, it results in a compile error (which is probably the
right behavior!). Simply not importing the external function and using
the fully qualified name would facilitate composion, though. Here's
an example of a broken module:

```erlang
-module(experiments).
-import(lists, [map/2]).
-export([demo/0]).

demo() -> map(fun(X) -> X + 1 end, [1,2,3]).
map(F,L) -> {F, L}. 
```

-------------------------------------------------------------------------------

It may be useful during debugging to use the `-compile(export_all)` option,
which will make all of the functions from the module callable externally.

-------------------------------------------------------------------------------

`-vsn(Version)` allows setting version metadata that can be useful for
documentation or analysis tools.

-------------------------------------------------------------------------------

Custom attributes can be defined, e.g. `-author`, `-purpose`, etc. This
metadata is extractable from loaded code using `attrs:module_info`. It looks 
like it's also possible to extract the information without loading
the code by using a low level BEAM vm function (see pp120). This
may hint at other pre-processing that can be done on Erlang code, but
I'm not sure what the applications would be. The point to remember here
is just that Erlang is a compiled language, so it has entry points
for code analysis that wouldn't be easy to replicate in Ruby.

-------------------------------------------------------------------------------

`begin` and `end` are used for much the same purpose as in Ruby,
to group together a set of related expressions. This is useful for
code which expects to receive a single expression, like list
comprehensions. Seems like an edge case, though.

-------------------------------------------------------------------------------

Booleans are represented by the atoms `true` and `false`, which are used by
convention in many functions, but are not distinct types of their own. Boolean
operations (`not`, `and`, `or`, `xor`) operate only on these atoms. This is
unlike Ruby where all objects except `false` or `nil` evaluate to true. Keep
in mind that boolean expressions in Erlang evaluate both sides of the
operation before doing a comparision by default. For short-circuit evaluation,
`orelse`/`andalso` are used.

-------------------------------------------------------------------------------

Erlang has a syntax similar to Ruby's `&:something`:

```erlang
lists:map(fun math_functions:even/1, [1,3,4,3,6,8,3]).
```

-------------------------------------------------------------------------------

It turns out that the last time I was studying Erlang, source code *was*
interpreted using Latin1, but now it uses Unicode! (String type still
does not exist though)

-------------------------------------------------------------------------------

`after` can be used in combination with a `receive` block to implement timeout
behavior. It's also possible to not include any matchers for messages, which
effectively creates a sleep operation.

-------------------------------------------------------------------------------

Erlang's dynamic code loading allows for new code to be compiled and
automatically loaded. This is useful for hot swapping code, but it's also
something that isn't semantically similar to Ruby. See examples from PE
pp124-126 for very confusing behavior which allows "two versions of a module
to be compiled at once, but no more than that". I imagine this will become
clearer once I have a chance to see how it works in practice, as well as what
the conventional code loading idioms are.

-------------------------------------------------------------------------------

Erlang has a preprocessor that supports macros. Its output can be displayed
by running `$erlc -P some_module.erl`. This will spit the generated source
into `some_module.P`.

-------------------------------------------------------------------------------

Erlang has the usual escape sequences, i.e. `\n`, `\t`, etc.

-------------------------------------------------------------------------------

pp129 hints at including library headers in a module, but there is no example
shown. I probably won't need to learn about loading external libraries until
later anyway.

-------------------------------------------------------------------------------

`++` adds two lists together, `--` subtracts lists. Note that unlike Ruby,
this is not a *set operation*, and processes elements in order. I don't yet
fully grasp the semantics of "List Subtraction".

```erlang
> [1,2,3,2,5,2]--[3,2,2].
[1,5,2]
```

-------------------------------------------------------------------------------

Macros can be used for substituting both constants and functions with
predefined text transformations. There are a few special macros built
into Erlang, including `?FILE`, `?MODULE` and `?LINE`. Macros also have
some C-style control flow features, like `-ifdef`, `ifndef`, etc. This makes it
possible to do some dynamic expansions for things like debugging functions.
See example on pp131: the syntax is not exactly pretty, but the functionality
is possibly useful.

-------------------------------------------------------------------------------

Patterns can be assigned to temporary variables, alllowing for their reuse in
function bodies. See pp132 for an abstract example of this, hopefully we'll
see a practical one later in the book.

-------------------------------------------------------------------------------

The numeric stack in Erlang consists only of integers and floats.

-------------------------------------------------------------------------------

All erlang processes have their own "process dictionary" which is basically a
hash of mutable state! The caveat of using it is that it leads to code that is
not side-effect free (even though it's probably still better than Ruby because
of the actor-based concurrency model and no access to object internals). It is
possibly safe for write-once variables, though (i.e. keys that get values
exactly once and never change), but the general advice is to avoid using it.

-------------------------------------------------------------------------------

References are arbitrary and globally unique identifiers generated by
`erlang:make_ref()`. These are useful for tagging data with a 
lookup key.

-------------------------------------------------------------------------------

Starting on the bowling calculator had me asking the question of when to use
tuples vs. list. Googling found me this answer:

>> I'm going through the Erlang tutorial,and I don't understand 
>> very well the difference between tuples and lists. 

> The short answer is: 
>  Lists are logically meant to represent entities that may vary in length. 
>  Entities of fixed length are better represented with tuples. 

> You could in principle use tuples and lists interchangeably to represent 
> some data. The difference is in efficiency and storage size. 

> A tuple is basically an array, you can do random access to elements and the 
> elements are stored contiguously in memory. A list has to be traversed to 
> access its elements, and stores two extra pointers for every element. 

> On the other hand, resizing a tuple means that all elements needs to be 
> copied into a new structure. For a list, adding an element at the head is 
> very fast and simple. 

SOURCE:
http://erlang.2086793.n4.nabble.com/Tuples-vs-lists-tp2087352p2087354.html 

-------------------------------------------------------------------------------

Looks like `case` expressions don't use `true -> ...` as I mentioned in earlier
notes for else, but some sort of empty pattern, e.g. `_ -> ...`. Confused me for
a few minutes. :-/

-------------------------------------------------------------------------------

The code I wrote for my bowling score calculator has no error handling, and
is a terrible mess of case statements, but it seems to be working! (a9b3302)

I will definitely work on cleaning up its code, but I'm not sure how many
more features I will add to it before working on Dining Philosophers. This
depends on how my book reading work goes tomorrow.

It may also be a good exercise to compare the bowling calculator code to
equivalent Ruby code, but I'm unsure whether I want to spend the time
writing that code right now. Maybe look for someone else's work?

## January 7, 2014

**Total Practice Time: ..**

Current plan is to spend one more day on "sequential erlang" part of PE book,
and wrap up cleanup on bowling calculator. If time permits, may begin
work on Dining Philosophers, or at least start researching it.
