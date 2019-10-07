extends Area2D

var player_contact: bool = false
var player: Player
var coins: int

func _process(delta):
    if player_contact:
        if Input.is_action_just_pressed("action_key") and player.coin_count >= 100:
            get_tree().change_scene("res://MainScene/YouWin.tscn")
            


func _on_Node2D_body_entered(body):
    if body is Player:
        player_contact = true
        player = body


func _on_Node2D_body_exited(body):
    if body is Player:
        player_contact = false
