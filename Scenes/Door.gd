extends Area2D

export var next_room = ""

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
		var dir = body.dir

		if dir == Vector2(1, 0):
			body.position = Vector2(8, body.position.y)
		elif dir == Vector2(-1, 0):
			body.position = Vector2(SCREEN_WIDTH - 8, body.position.y)
		elif dir == Vector2(0, 1):
			body.position = Vector2(body.position.x, 16)
		elif dir == Vector2(0, -1):
			body.position = Vector2(body.position.x, SCREEN_HEIGHT - 16)
		

		call_deferred("player_entered_func", next_room)

func player_entered_func(next_room):
	emit_signal("player_entered", next_room)
