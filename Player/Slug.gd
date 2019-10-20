extends Node2D

var motion : Vector2
var facing_right : bool
var initial_speed : float = 10
var acceleration : float = 5
var max_speed : float = 300

func _ready():
    motion = Vector2(initial_speed if facing_right else -initial_speed, 0)

func _process(delta):
    $Area2D/Sprite.flip_h = not facing_right
    position += motion * delta
    motion.x += acceleration if facing_right else -acceleration
    motion.x = clamp(motion.x, -max_speed, max_speed)
    


func _on_Area2D_area_entered(area):
    if area is BaddieCollision:
        area.get_parent().hurt()
        queue_free()

func _on_BulletTime_timeout():
    queue_free()


func _on_Area2D_body_entered(body):
    if body is TileMap:
        queue_free()
