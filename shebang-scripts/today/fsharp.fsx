#!/usr/bin/env -S dotnet fsi

// TODO: Directly calling /usr/bin/env dotnet does not work

open System

printfn "%s" (DateTime.Now.Date.ToString("yyyy-MM-dd"))
