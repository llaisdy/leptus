-module(leptus_hooks).

-export([console_log/4]).


console_log(Status, Headers, _, Req) ->
    %% [%Y-%m-%d %H:%M:%S]  METHOD URL  STATUS  CONTENT-LENGTH
    {{Year, Month, Day}, {Hour, Min, Sec}} = erlang:localtime(),
    {Method, _} = cowboy_req:method(Req),
    Uri = leptus_req:uri(Req),
    ContentLength = get_value(<<"content-length">>, Headers, 0),
    io:format("[~w-~w-~w ~w:~w:~w]  ~s ~s  ~w  ~s~n",
              [Year, Month, Day, Hour, Min, Sec, Method, Uri,
               Status, ContentLength]),
    Req.


%% internal
get_value(Key, Proplist, Default) ->
    case lists:keyfind(Key, 1, Proplist) of
        {_, Value} -> Value;
        _ -> Default
    end.