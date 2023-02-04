extends Node

export var current_room = ""

func _ready():
	set_room()

func set_room():
	var room_scene = load("res://Scenes/Rooms/" + current_room + ".tscn").instance()
	add_child(room_scene)

	var top_layer = get_node(current_room + "/TopLayer").duplicate()
	var bottom_layer = get_node(current_room + "/BottomLayer").duplicate()
	var interactives = get_node(current_room + "/Interactives").duplicate()

	var game_root = get_node("/root/Game")

	# clear all the children of the top and bottom layers
	delete_children(game_root.get_node("TopLayer"))
	delete_children(game_root.get_node("BottomLayer"))
	delete_children(game_root.get_node("Interactives"))

	# add the new top and bottom layers
	game_root.get_node("TopLayer").add_child(top_layer)
	game_root.get_node("BottomLayer").add_child(bottom_layer)
	game_root.get_node("Interactives").add_child(interactives)

	# free the room scene
	room_scene.queue_free()

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
