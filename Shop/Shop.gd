extends Node2D

func _on_InteractionZone_body_entered(body):
    if body is Player:
        $Label.visible = true
        $ShopkeeperTalk.play()


func _on_InteractionZone_body_exited(body):
    if body is Player:
        $Label.visible = false
