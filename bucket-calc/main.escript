#!/usr/bin/env escript

main(_) ->
    Start = 1,
    End = 100000,
    NumBins = 20,
    LogBase = math:pow(End / Start, 1 / NumBins),
    BinEdges = [round(Start * math:pow(LogBase, I)) || I <- lists:seq(0, NumBins)],
    io:format("~p~n", [BinEdges]).
