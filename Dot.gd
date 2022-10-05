extends Area2D
class_name Dot

export var velocity : Vector2
export var speed := 30

var nearby_dots := []


func init_rand(r : RandomNumberGenerator, screen_extents : Vector2):
	var x := screen_extents.x * 2 * r.randf() - screen_extents.x
	var y := screen_extents.y * 2 * r.randf() - screen_extents.y
	
	position = Vector2(x, y)
	velocity = Vector2(r.randf(), r.randf())


func _process(delta):
	position += velocity * speed * delta
	update()


func _draw():
	for dot in nearby_dots:
		var to_pos : Vector2 = to_local(dot.position)
		var dist := to_pos.length()
		var max_dist : float = $CollisionShape2D.shape.radius * 2
		
		if dist > max_dist:
			continue
		
		var c := Color.white
		c.a = 1 - dist / max_dist
		
		draw_line(Vector2(), to_pos / 2, c, 2.0)
	
	draw_circle(Vector2(), 1.0, Color.white)


func _on_Dot_area_entered(area):
	if area is get_script():
		nearby_dots.append(area)


func _on_Dot_area_exited(area):
	if area is get_script():
		nearby_dots.erase(area)
