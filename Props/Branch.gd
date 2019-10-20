tool
extends Node2D


export (bool) var flipped: bool = false

func _process(delta):
    $StaticBody2D/Sprite.flip_h = flipped
