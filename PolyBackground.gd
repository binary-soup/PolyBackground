extends Node2D

export var rseed := 0
export var num_dots := 50


func _ready():
	var r := RandomNumberGenerator.new()
	r.seed = rseed
	
	for i in num_dots:
		var dot : Dot = preload("res://Dot.tscn").instance()
		dot.init_rand(r, _play_area_extents())
		
		add_child(dot)


func _play_area_extents() -> Vector2:
	return $PlayArea/CollisionShape2D.shape.extents


func _on_PlayArea_area_exited(area):
	var extents := _play_area_extents()
	
	if area.position.x < -extents.x:
		area.position.x = extents.x + abs(area.position.x + extents.x)
	elif area.position.x > extents.x:
		area.position.x = -extents.x - abs(area.position.x - extents.x)
		
	if area.position.y < -extents.y:
		area.position.y = extents.y + abs(area.position.y + extents.y)
	elif area.position.y > extents.y:
		area.position.y = -extents.y - abs(area.position.y - extents.y)
