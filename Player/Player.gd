extends KinematicBody2D

const GRAVITY: float = 9.8
var facing_right: bool = true
var motion: Vector2 = Vector2(0, 0)

var accel: float = 4.0

var max_speed: float = 64.0
var jump_force: float = 192.0
var jump_extra: float = 0.04

func _process(delta) -> void:
    motion.y += GRAVITY
    if Input.is_action_pressed("ui_right"):
        motion.x += accel
    elif Input.is_action_pressed("ui_left"):
        motion.x -= accel
    else:
        motion.x = lerp(motion.x, 0, 0.05)
    motion.x = clamp(motion.x, -max_speed, max_speed)
    if is_on_floor():
        if Input.is_action_just_pressed("ui_accept"):
            motion.y -= jump_force
    else:
        if Input.is_action_pressed("ui_accept"):
            if motion.y < 0:
                motion.y -= jump_force * jump_extra

    if motion.x > 0:
        facing_right = true
    if motion.x < 0:
        facing_right = false

    motion = move_and_slide(motion, Vector2.UP)
    
    animate()
   
    $Sprite.flip_h = not facing_right
    
func animate() -> void:
    if abs(motion.x) > 1:
        $AnimationPlayer.current_animation = "Walking"
    else:
        $AnimationPlayer.current_animation = "Idle"
    if (motion.y) > 1:
        $AnimationPlayer.current_animation = "Falling"
    if (motion.y) < -1:
        $AnimationPlayer.current_animation = "Jumping"