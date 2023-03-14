extends Node

export var current_room = ""

func _ready():
	get_all_doors()
	set_room()


func get_all_doors():
	var interactives = get_node("/root/Game/Interactives")
	for n in interactives.get_children():
		for c in n.get_children():
			if "Door" in c.name:
				print(c.name)
				c.connect("player_entered", self, "new_room", [current_room])


func new_room(room, other_thing):
	print(other_thing) # idk what this is but it's needed
	current_room = room
	set_room()

func set_room():
	var room_scene = load("res://Scenes/Rooms/" + current_room + ".tscn").instance()
	add_child(room_scene)

	var top_layer = get_node(current_room + "/TopLayer").duplicate()
	var bottom_layer = get_node(current_room + "/BottomLayer").duplicate()
	var interactives = get_node(current_room + "/Interactives").duplicate()

	var game_root = get_node("/root/Game")
	var note_manager = get_node("/root/Game/NoteManager/NoteManager")

	# clear all the children of the top and bottom layers
	delete_children(game_root.get_node("TopLayer"))
	delete_children(game_root.get_node("BottomLayer"))
	delete_children(game_root.get_node("Interactives"))

	# add the new top and bottom layers
	game_root.get_node("TopLayer").add_child(top_layer)
	game_root.get_node("BottomLayer").add_child(bottom_layer)
	game_root.get_node("Interactives").add_child(interactives)

	note_manager.connect_to_triggers()

	get_all_doors()

	# have the player connect to all the keys in the room
	var player = get_node("/root/Game/Player")
	player.connect_to_keys()

	# free the room scene
	room_scene.queue_free()

static func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
