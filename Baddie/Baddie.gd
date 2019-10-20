extends Node2D

var facing_right: bool = false
var coin : PackedScene = preload("res://Coin/PhysCoin.tscn")

export (int) var hp: int = 2
export (int) var drop: int = 3
export (float) var speed: float = 60

func _physics_process(delta) -> void:
    $Sprite.flip_h = facing_right
    position.x += speed * delta if facing_right else -speed * delta

func hurt():
    hp -= 1
    if hp <= 0:
        call_deferred("spawn_coins")
    else:
        $BaddieHurtSound.play()
        $AnimationPlayer.current_animation = "Hurt"
    
func spawn_coins():
# warning-ignore:unused_variable
    for i in range(drop):
        var c = coin.instance()
        c.position = global_position
        get_tree().root.add_child(c)
    queue_free()

func _on_LeftTileCheck_body_exited(body):
    if body is TileMap:
        facing_right = true


func _on_RightTileCheck_body_exited(body):
    if body is TileMap:
        facing_right = false


func _on_Area2D_body_entered(body):
    if body is Player:
        if not body.dead:
            body.call_deferred("hurt", 3)


func _on_LeftTileCheck2_body_entered(body):
    if body is TileMap:
        facing_right = true


func _on_RightTileCheck2_body_entered(body):
    if body is TileMap:
        facing_right = false


func _on_AnimationPlayer_animation_finished(anim_name):
    if anim_name == "Hurt":
        $AnimationPlayer.current_animation = "Default"
