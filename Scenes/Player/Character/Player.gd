extends Area2D
signal hit
signal is_dead

@export
var speed = 300
var screen_size
var sprite : AnimatedSprite2D
var collision : CollisionShape2D
var lifes = 3

var target = Vector2()
var can_move = false

@onready var joystick = $"../HUD/Joystick" 

func _ready():
	screen_size = get_viewport_rect().size
	sprite = $Sprite
	collision = $CollisionShape2D
	target = Vector2(240, 450)

func _input(event):
	if event is InputEventScreenDrag:
		target = event.position
		can_move = true

func _on_hud_start_game():
	lifes = 3
	$"../HUD".fill_heart(lifes)
	position = $"../StartPosition".position
	show()
	collision.disabled = false
	
func _process(delta):
	if(can_move):
		move(delta)

func _on_player_area_entered(_area):
	lifes -= 1
	emit_signal('hit')
	if(lifes == 0):
		emit_signal('is_dead')
		collision.set_deferred('disabled', true)
		hide()
	else:
		collision.set_deferred('disabled', true)
		await tween_color()
		collision.set_deferred('disabled', false)
		$Sprite.visible = true

func tween_color():
	for n in 10:
		await get_tree().create_timer(.1).timeout
		$Sprite.visible = false
		await get_tree().create_timer(.1).timeout
		$Sprite.visible = true

func move(delta):
	var velocity = joystick.get_velo()
	if(velocity != null):
		if velocity.x != 0:
			sprite.animation = 'walk'
			sprite.flip_v = false
			sprite.flip_h = velocity.x < 0
		elif velocity.y != 0:
			sprite.animation = 'up'
		
		sprite.flip_v = velocity.y > 20
		
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			sprite.play()
		else:
			sprite.stop()
		
		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)	
