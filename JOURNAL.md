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
