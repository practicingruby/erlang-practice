-module(concurrency).
-export([start/2]).

% Solution is from http://forums.pragprog.com/forums/27/topics/124

start(Atom, Fun) ->
    Registrant = self(),
    spawn(
        fun() ->
            try register(Atom, self()) of
                true ->
                    Registrant ! true,
                    Fun()
            catch
                error:badarg ->
                    Registrant ! false
            end
        end),
    receive
        true  -> true;
        false -> erlang:error(badarg)
    end.
