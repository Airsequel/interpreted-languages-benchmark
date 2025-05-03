#!/usr/bin/env -S dotnet fsi

// TODO: Directly calling /opt/homebrew/bin/dotnet does not work

open System

printfn "%s" (DateTime.Now.Date.ToString("yyyy-MM-dd"))
