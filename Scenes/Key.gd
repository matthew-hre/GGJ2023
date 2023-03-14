extends Area2D

signal player_entered(key_type)

export var key_type = "red"

func _ready():
	if key_type == "red":
		$Sprite.set_texture(load("res://Assets/template/redkey.png"))
	elif key_type == "blue":
		$Sprite.set_texture(load("res://Assets/template/bluekey.png"))
	elif key_type == "yellow":
		$Sprite.set_texture(load("res://Assets/template/yellowkey.png"))

	var connection = connect("body_entered", self, "_on_body_entered")
	if connection == OK:
		pass

func _on_body_entered(body):
	if body.name == "Player":
		print("Player entered key")
		emit_signal("player_entered", key_type)
		queue_free()
