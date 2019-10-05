extends KinematicBody2D
class_name Player


var bullet: PackedScene = preload("res://Player/Slug.tscn")

const GRAVITY: float = 9.8
var facing_right: bool = true
var motion: Vector2 = Vector2(0, 0)

var accel: float = 4.0

var coin_count: int = 0
var hearts: int = 10
var checkpoint: Vector2

var dead: bool = false

var max_speed: float = 64.0
var jump_force: float = 192.0
var jump_extra: float = 0.04
var jumps: int = 0

var has_doublejump: int = 0
var has_slugs: int = 1

onready var heart: PackedScene = preload("res://Player/Heart.tscn")

func _ready() -> void:
    new_checkpoint(global_position)
    update_coin_count(0)

func _physics_process(delta) -> void:
    motion.y += GRAVITY
    if Input.is_action_pressed("ui_right"):
        motion.x += accel if motion.x < max_speed else 0
        if motion.x > 0:
            facing_right = true

    elif Input.is_action_pressed("ui_left"):
        motion.x -= accel if motion.x > -max_speed else 0
        if motion.x < 0:
            facing_right = false

    else:
        motion.x = lerp(motion.x, 0, 0.1)
    if is_on_floor():
        if Input.is_action_just_pressed("ui_accept"):
            motion.y -= jump_force
            $JumpSound.pitch_scale = 1.0
            $JumpSound.play()
        jumps = 0
    else:
        if Input.is_action_just_pressed("ui_accept"):
            print("%s" % [jumps])
            if jumps < has_doublejump:
                jumps += 1
                motion.y -= jump_force / jumps
                $JumpSound.pitch_scale = 1.0 + (float(jumps) * 0.3)
                $JumpSound.play()
        if Input.is_action_pressed("ui_accept"):
            if motion.y < 0:
                motion.y -= jump_force * jump_extra


    if not dead:
        if Input.is_action_just_pressed("shoot") and has_slugs > 0:
            var b = bullet.instance()
            b.position = global_position
            b.facing_right = facing_right
            get_tree().root.add_child(b)
            $ShootSound.play()
            motion.x += -300 if facing_right else 300
        motion = move_and_slide(motion * 60.0 * delta, Vector2.UP)
    
    animate()
   
    $PlayerSprite.flip_h = not facing_right
    
func animate() -> void:
    if abs(motion.x) > 1:
        $AnimationPlayer.current_animation = "Walking"
    else:
        $AnimationPlayer.current_animation = "Idle"
    if (motion.y) > 1:
        $AnimationPlayer.current_animation = "Falling"
    if (motion.y) < -1:
        $AnimationPlayer.current_animation = "Jumping"
        
func update_coin_count(value: int) -> void:
    coin_count += value
    $CurrencyBalloon/CurrencyLabel.text = "%s" % [coin_count]
    $CurrencyBalloonTimeout.start(1.0)
    if value != 0:
        $CurrencyBalloon.visible = true
    if value > 0:
        $CoinSound.play()

func _on_CurrencyBalloonTimeout_timeout():
    $CurrencyBalloon.visible = false

func hurt(value: int) -> void:
#    for i in range(value):
#        if hearts > 0:
#            var h = heart.instance()
#            h.position = global_position
#            get_tree().root.add_child(h)
#            hearts -= 1
    if not dead:
        dead = true
        $RespawnTimer.start(3.0)
        $HurtParticles.restart()
        $HurtParticles.emitting = true
        $PlayerSprite.visible = false
        $HurtSound.play()
            
func new_checkpoint(where : Vector2):
    checkpoint = where
    
func use_checkpoint():
    dead = false
    $PlayerSprite.visible = true
    motion = Vector2.ZERO
    position = checkpoint

func _on_RespawnTimer_timeout():
    use_checkpoint()
