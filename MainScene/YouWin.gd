extends Control

var coin: PackedScene = preload("res://Coin/PhysCoin.tscn")


func _ready():
    $CanvasLayer/CoinCount.text = "You collected %s coins!" % [Global.coin_count]
    _spawn_coins()
    
func _spawn_coins():
    for i in range(Global.coin_count):
        var c = coin.instance()
        c.position = Vector2(0, 0)
        add_child(c)