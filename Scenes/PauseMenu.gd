extends Control

var shown = false

# get the player node
onready var player = get_node("/root/Game/Player")

# get the RedKey child node
onready var redKey = get_node("RedKey")

# get the BlueKey child node
onready var blueKey = get_node("BlueKey")

# get the YellowKey child node
onready var yellowKey = get_node("YellowKey")

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		if !shown:
			get_tree().paused = true
			visible = true
			shown = true

			# if the player has the red key, show the red key
			if player.has_red_key:
				redKey.visible = true
			else:
				redKey.visible = false

			# if the player has the blue key, show the blue key
			if player.has_blue_key:
				blueKey.visible = true
			else:
				blueKey.visible = false

			# if the player has the yellow key, show the yellow key
			if player.has_yellow_key:
				yellowKey.visible = true
			else:
				yellowKey.visible = false
		else:
			get_tree().paused = false
			visible = false
			shown = false

func _ready():
	visible = false
	shown = false
