extends KinematicBody2D
class_name Player


var bullet: PackedScene = preload("res://Player/Slug.tscn")

const GRAVITY: float = 14.8
var facing_right: bool = true
var motion: Vector2 = Vector2(0, 0)

var accel: float = 4.0

var coin_count: int = 0
var total_coins_collected: int = 0
var checkpoint: Vector2

var dead: bool = false

# warning-ignore:unused_class_variable
var max_speed: float = 96.0
var jump_force: float = 256
var jump_extra: float = 0.035
var jumps: int = 0

# warning-ignore:unused_class_variable
var submerged: bool = false

var has_doublejump: int = 0
var has_slugs: int = 0
var has_divinggear: int = 0

# warning-ignore:unused_class_variable
var subject: String = "howtobuy"

func _ready() -> void:
    new_checkpoint(global_position)
    update_coin_count(0)
    $CoinSound.play()

# warning-ignore:unused_argument
func _physics_process(delta) -> void:
    Global.time += delta
    $HeadsUpDisplay/Score/ScoreLabel.text = "%s" % [Global.score]
    motion.y += GRAVITY if not submerged else GRAVITY/4
    if Input.is_action_pressed("ui_right"):
        motion.x += accel if motion.x < max_speed else 0.0
        if motion.x > 0:
            facing_right = true

    elif Input.is_action_pressed("ui_left"):
        motion.x -= accel if motion.x > -max_speed else 0.0
        if motion.x < 0:
            facing_right = false

    else:
        motion.x = lerp(motion.x, 0, 0.1)

    if is_on_floor():
        if Input.is_action_just_pressed("ui_accept"):
            motion.y -= jump_force
            $JumpSound.pitch_scale = 0.9 + (randf() * 0.2)
            $JumpSound.play()
        jumps = 0
        if $DoubleJumpParticles.emitting == true:
            $DoubleJumpParticles.emitting = false
    else:
        if Input.is_action_just_pressed("ui_accept"):
            if jumps < has_doublejump:
                jumps += 1
                motion.y = -jump_force / jumps
                $JumpSound.pitch_scale = 1.0 + (float(jumps) * 0.3)
                $JumpSound.play()
                $DoubleJumpParticles.emitting = true
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
            motion.x += -100 if facing_right else 100
        motion = move_and_slide(motion, Vector2.UP)
    
    animate()
   
    $PlayerSprite.flip_h = not facing_right
    
func animate() -> void:
    
    $HeadsUpDisplay/Upgrades/Slot1/DoubleJump.visible = has_doublejump
    $HeadsUpDisplay/Upgrades/Slot2/SlugShot.visible = has_slugs
    $HeadsUpDisplay/Upgrades/Slot3/DivingGear.visible = has_divinggear
    
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
    $HeadsUpDisplay/CoinCount/CurrencyLabel.text = "%s" % [coin_count]
    if value > 0:
        $CoinSound.play()
        total_coins_collected += value
    Global.coin_count = coin_count
    Global.coins_collected += value if value > 0 else 0

# warning-ignore:unused_argument
func hurt(value: int) -> void:
    if not dead:
        Global.death_count += 1
        dead = true
        $RespawnTimer.start(3.0)
        $HurtParticles.restart()
        $HurtParticles.emitting = true
        $PlayerSprite.visible = false
        $HurtSound.play()
        $DoubleJumpParticles.emitting = false
            
func new_checkpoint(where : Vector2):
    checkpoint = where
    
func use_checkpoint():
    dead = false
    $PlayerSprite.visible = true
    motion = Vector2.ZERO
    position = checkpoint

func _on_RespawnTimer_timeout():
    use_checkpoint()
