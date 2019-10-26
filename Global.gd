extends Node

var coin_count: int = 0
var coins_collected: int = 0
var death_count: int = 0
var time: float = 0
var score: int = 0

func _process(delta):
    score = (Global.coins_collected * 1000) - (Global.death_count * 2000) - (ceil(Global.time * 25) * 1)
    if score < 0:
        score = 0
    if Input.is_action_just_pressed("fullscreen"):
        OS.window_fullscreen = not OS.window_fullscreen
