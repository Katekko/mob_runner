extends Area2D

@onready var big_circle = $BigCircle as Sprite2D
@onready var small_circle = $BigCircle/SmallCircle as Sprite2D
@onready var max_distance = $CollisionShape2D.shape.radius as float

var drag_velocity
var drag_position
var drag_relative

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		touched = event.is_pressed()
		
	if event is InputEventScreenDrag:
		if touched:
			drag_velocity = event.velocity
			drag_position = event.position
			drag_relative = event.relative
	
func _process(_delta):
	if touched:
		small_circle.position = get_local_mouse_position()
		var diffPosition = small_circle.position -  big_circle.position
		var clampX = clamp(diffPosition.x, (-max_distance * 6) * PI /2, (max_distance * 6) * PI /2)
		var clampY = clamp(diffPosition.y, (-max_distance * 6) * PI /2, (max_distance * 6) * PI /2)
		small_circle.position = big_circle.position + Vector2(clampX, clampY)
	else:
		drag_velocity = null
		
func get_velo():
	var joy_velo = Vector2(0,0)
	joy_velo.x = small_circle.position.x / max_distance
	joy_velo.y = small_circle.position.y / max_distance
	return drag_velocity
	
