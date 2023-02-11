extends Control

var shown = false
# if escape pressed, show

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		if !shown:
			get_tree().paused = true
			visible = true
			shown = true
		else:
			get_tree().paused = false
			visible = false
			shown = false

func _ready():
	visible = false
	shown = false
