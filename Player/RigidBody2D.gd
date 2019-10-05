extends RigidBody2D

var speed: float = 0
var direction: float = 0

func _ready():
    direction = randf() * 2 * PI
    apply_central_impulse(Vector2(cos(direction) * speed, sin(direction) * speed))
    