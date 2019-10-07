extends Control

var coin: PackedScene = preload("res://Coin/PhysCoin.tscn")
var spawned: int = 0

func _ready():
    if Global.coin_count >= 200:
        $CanvasLayer/Congratulations.text = "You're quite the overachiever, aren't you?\n\nCongratulations!"
    $CanvasLayer/CoinCount.text = "You collected %s coins!" % [Global.coin_count]
    
func _process(delta):
    if spawned < Global.coin_count:
        var c = coin.instance()
        c.position = $CanvasLayer/CoinCount/Node2D.global_position
        add_child(c)
        spawned += 1