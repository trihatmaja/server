%%%-------------------------------------------------------------------
%% @doc server public API
%% @end
%%%-------------------------------------------------------------------

-module(server_app).

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
        {'_', [{"/", http_handler, []}]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    server_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
