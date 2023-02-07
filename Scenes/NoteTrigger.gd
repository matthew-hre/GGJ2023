extends Area2D

signal player_entered(filepath)

export var filepath = ""
export var persistent = false
export var show_sprite = true

func _ready():
	if !show_sprite:
		$Sprite.visible = false

	var connection = connect("body_entered", self, "_on_body_entered")
	if connection:
		# yeah, we connected
		pass

# when the player enters the area, emit a signal
func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered", filepath, persistent)
		# remove self from the scene
		queue_free()
