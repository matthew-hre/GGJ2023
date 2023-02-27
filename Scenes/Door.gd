extends Area2D

export var next_room = ""

export var new_X = 0
export var new_Y = 0


signal player_entered(next_room)

var SCREEN_WIDTH = 192
var SCREEN_HEIGHT = 168

# if the player enters us, we'll change the room and set their position to the direction they came from

func _ready():
	var connection = connect("body_entered", self, "_on_body_entered")
	if connection == OK:
		pass

func _on_body_entered(body):
	if body.name == "Player":
		body.position = Vector2(new_X, new_Y)
		call_deferred("player_entered_func", next_room)

func player_entered_func(next_room):
	emit_signal("player_entered", next_room)
