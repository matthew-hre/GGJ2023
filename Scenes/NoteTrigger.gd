extends Area2D

signal player_entered(filepath)

export var filepath = ""

func _ready():
	var connection = connect("body_entered", self, "_on_body_entered")
	if connection:
		# yeah, we connected
		pass

# when the player enters the area, emit a signal
func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered", filepath)
		# remove self from the scene
		queue_free()
