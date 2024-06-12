#!/usr/bin/env -S godot -s

extends SceneTree

func _init():
    print(Time.get_date_string_from_system())
    quit()
