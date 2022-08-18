extends Button

func _ready():
	connect("pressed", _button_pressed)
	position.x += 100

func _process(delta):
	pass

func _button_pressed():
	print("Hello world!")
