extends Control

func _process(delta):
    if Input.is_action_pressed("ui_accept"):
        get_tree().change_scene("res://MainScene/MainScene.tscn")

func _on_PromptTimer_timeout():
    $sluggishgrind/spacebar.visible = true
    
