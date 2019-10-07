extends Node2D

var player_contact: bool = false
var player: Player

var price: int = 20
var bought: bool = false

func _physics_process(delta):
    if not bought:
        $Label.visible = player_contact
        if player_contact:
            if player.coin_count >= price:
                if Input.is_action_just_pressed("action_key"):
                    player.has_slugs += 1
                    player.update_coin_count(-price)
                    $PurchaseSound.play()
                    bought = true
                    player.subject = "slugshot"
    else:
        $Label.visible = false


func _on_Area2D_body_entered(body):
    if body is Player:
        player = body
        player_contact = true


func _on_Area2D_body_exited(body):
    if body is Player:
        player_contact = false
