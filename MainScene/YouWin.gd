extends Control

var coin: PackedScene = preload("res://Coin/PhysCoin.tscn")
var spawned: int = 0
var score: int = 0

func _ready():
    $CanvasLayer/CoinCount.text = "You collected %s coins!\nYou died %s times.\nYou explored the dungeon for %s seconds\n\nAnd so, your final score is %s!\n\nCongratulations!" % [Global.coin_count, Global.death_count, ceil(Global.time), Global.score]