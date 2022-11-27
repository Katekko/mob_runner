extends RigidDynamicBody2D

func _ready():
	var animated_sprite = $AnimatedSprite2D
	animated_sprite.playing = true
	var mob_types = animated_sprite.frames.get_animation_names()
	animated_sprite.animation = mob_types[randi() % mob_types.size()]
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_area_entered(_area):
	queue_free()
