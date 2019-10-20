extends Node

var coin_count: int = 0

func _process(delta):
    if Input.is_action_just_pressed("fullscreen"):
        OS.window_fullscreen = not OS.window_fullscreen
