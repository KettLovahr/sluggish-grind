extends Node2D

var active: bool = false
var player: Player

func _ready():
    pass # Replace with function body.
    
func _process(delta) -> void:
    $Area2D/Sprite.frame = 1 if active else 0
    if player:
        if player.checkpoint != global_position:
            active = false


func _activate():
    if not active:
        active = true
        $CheckpointSound.play()


func _on_Area2D_body_entered(body):
    if body is Player:
        player = body
        _activate()
        body.new_checkpoint(global_position)
