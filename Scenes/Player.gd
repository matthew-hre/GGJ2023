extends KinematicBody2D

export (int) var speed = 1400

export var has_blue_key = false
export var has_red_key = false
export var has_yellow_key = false

var key_type = ""

var velocity = Vector2()
var can_move = true
var dir = Vector2()

func _ready():
	# connect to the NoteManager's "note_hit" signal. the NoteManager is in the root node
	var _connect1 = get_tree().current_scene.get_node("NoteManager/NoteManager").connect("note_enter", self, "disable_movement")
	var _connect2 = get_tree().current_scene.get_node("NoteManager/NoteManager").connect("note_exit", self, "enable_movement")

	connect_to_keys()

func disable_movement():
	can_move = false

func enable_movement():
	can_move = true

func connect_to_keys():
	# for every node in the Interacives node
	for node in get_tree().current_scene.get_node("Interactives/Interactives").get_children():
		print(node.name)
		# if the node is a key
		if "Key" in node.name:

			if node.key_type == "red" and has_red_key:
				node.queue_free()
				continue
			elif node.key_type == "blue" and has_blue_key:
				node.queue_free()
				continue
			elif node.key_type == "yellow" and has_yellow_key:
				node.queue_free()
				continue
				
			# connect to the key's "key_hit" signal
			print("connected to key")
			node.connect("player_entered", self, "key_get", [key_type])

func key_get(key_type, _other_thing):
	print("key get")
	# set the key type to the key type passed in
	self.key_type = key_type
	# set the key type to true
	match key_type:
		"blue":
			has_blue_key = true
		"red":
			has_red_key = true
		"yellow":
			has_yellow_key = true

	self.key_type = ""

func get_input():
	if can_move:
		velocity = Vector2()
		if Input.is_action_pressed("right"):
			velocity.x += 1
			dir = Vector2(1, 0)
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			dir = Vector2(-1, 0)
		if Input.is_action_pressed("down"):
			velocity.y += 1
			dir = Vector2(0, 1)
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			dir = Vector2(0, -1)
		
		if velocity.x != 0 and velocity.y != 0:
			$Sprite.animation = "walk-up-down"
		elif velocity.x > 0:
			$Sprite.animation = "walk-right"
		elif velocity.x < 0:
			$Sprite.animation = "walk-left"
		elif velocity.y > 0:
			$Sprite.animation = "walk-up-down"
		elif velocity.y < 0:
			$Sprite.animation = "walk-up-down"
			
		velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity * delta)
	# if we're moving, play the "walk" animation
	if velocity.length() > 0:
		$Sprite.play()
	else:
		$Sprite.stop()
		$Sprite.set_frame(0)
