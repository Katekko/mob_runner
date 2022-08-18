extends Node
signal update_difficulty

var score = 0
var ammount_difficulty = 0

func _ready():
	randomize()

func _on_hud_start_game():
	get_tree().call_group("mobs", "queue_free")
	update_score(0)
	$HUD.update_score(score)
	$StartTimer.start()
	$Background.start_timer_random_color()
	$MainMusicSound.play()

func _on_score_timer_timeout():
	update_score(score + 1)
	$HUD.update_score(score)

func _on_start_time_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	for n in ammount_difficulty:
		$MobPath.create_mob()

func _on_player_is_dead():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$DeathSound.play()
	$MainMusicSound.stop()

func update_score(num: int):
	score = num
	if(score % 10 == 0):
		emit_signal("update_difficulty")
	
	if(score % 30 == 0):
		ammount_difficulty += 1
