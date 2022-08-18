extends Sprite2D

@export
var id : int

var is_empty : bool = false

func _process(_delta):
	var name_image : String
	if(is_empty):
		name_image = "heart_empty.png"
	else:
		name_image = "heart_full.png"
	
	if(self.texture.resource_name == name_image): return
	self.texture =  load("res://Assets/UI/HUD/" + name_image)
	
func take_damage():
	is_empty = true

func fill():
	is_empty = false
