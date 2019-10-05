extends Node2D

var facing_right: bool = false

func _physics_process(delta) -> void:
    $Sprite.flip_h = facing_right
    position.x += 60 * delta if facing_right else -60 * delta


func _on_LeftTileCheck_body_exited(body):
    if body is TileMap:
        facing_right = true


func _on_RightTileCheck_body_exited(body):
    if body is TileMap:
        facing_right = false


func _on_Area2D_body_entered(body):
    if body is Player:
        body.call_deferred("hurt", 3)


func _on_LeftTileCheck2_body_entered(body):
    if body is TileMap:
        facing_right = true


func _on_RightTileCheck2_body_entered(body):
    if body is TileMap:
        facing_right = false
