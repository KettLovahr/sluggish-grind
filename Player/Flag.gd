extends Node2D

var active: bool = false

func _ready():
    pass # Replace with function body.

func _activate():
    if not active:
        active = true
        $Area2D/Sprite.frame = 1
        $CheckpointSound.play()


func _on_Area2D_body_entered(body):
    if body is Player:
        _activate()
        body.new_checkpoint(global_position)
