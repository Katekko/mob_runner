extends Path2D

@export
var mob_scene : PackedScene

var mobs = []
var difficulty = 1

func create_mob():
	# Create a new instance ofthe Mob scene.
	var mob = mob_scene.instantiate()
	mobs.push_front(mob)

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobSpawnLocation
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150 * difficulty, 250 * difficulty), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_main_add_difficulty(diff: int):
	difficulty += diff

func _on_main_replace_difficulty(diff: int):
	difficulty = diff 


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
