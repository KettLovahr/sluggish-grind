extends Node2D



func _on_Area2D_body_entered(body):
    if body is Player:
        if body.has_divinggear == 0:
            body.call_deferred("hurt", 3)
            body.motion.y -= 25
        else:
            body.submerged = true


func _on_Area2D_body_exited(body):
    if body is Player:
        if body.has_divinggear > 0:
            body.submerged = false
