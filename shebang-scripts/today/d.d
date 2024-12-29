#!/usr/bin/env rdmd

import std.stdio: writeln;
import std.datetime: Clock, SysTime, Date;

void main() {
    writeln(cast(Date)Clock.currTime());
}
