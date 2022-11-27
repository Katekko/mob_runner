extends ColorRect

func _ready():
	self.color = Color8(1, 0, 1)

func start_timer_random_color():
	$ChangeColorTimer.start()

func _on_change_color_timer_timeout():
	self.color = Color8(_get_random_color(), _get_random_color(), _get_random_color())
	
func _get_random_color():
	return randi() % 255

func _on_player_is_dead():
	self.color = Color8(1, 0, 1)
	$ChangeColorTimer.stop()
