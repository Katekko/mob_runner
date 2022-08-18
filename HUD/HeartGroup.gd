extends Node2D

var heart_list = []

func heart_list_is_reversed():
	return heart_list[0].id == 3 

func _ready():
	heart_list = get_children().duplicate()
	if(!heart_list_is_reversed()): heart_list.reverse()

func take_one_life():
	if(!heart_list_is_reversed()): heart_list.reverse()
	for heart in heart_list:
		if(!heart.is_empty):
			heart.take_damage()
			break

func fill_heart(number: int):
	if(heart_list_is_reversed()): heart_list.reverse()
	for num in number:
		heart_list[num].fill()
