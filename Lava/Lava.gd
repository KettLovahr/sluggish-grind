extends Node2D



func _on_Area2D_body_entered(body):
    if body is Player:
        body.call_deferred("hurt", 3)
        body.motion.y -= 25
