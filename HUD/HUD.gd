extends CanvasLayer
signal start_game

func _ready():
	$ScoreLabel.text = "0"
	$StartButton.show()

func _on_start_button_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func update_score(score: int):
	$ScoreLabel.text = str(score)	

func _on_player_hit():
	$HeartGroup.take_one_life()

func _on_player_is_dead():
	$StartButton.show()

func fill_heart(num : int):
	$HeartGroup.fill_heart(num)
