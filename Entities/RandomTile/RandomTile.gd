extends Node2D

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var tileNum = rng.randi_range(0, 179)
	var tileNumString = "%04d" % tileNum
	var spritePath = "res://Kenney/Tiles/tile_" + tileNumString + ".png"
	$StaticBody2D/Sprite.texture = load(spritePath)
