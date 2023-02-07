extends KinematicBody2D

export (int) var speed = 1400

var velocity = Vector2()
var can_move = true
var dir = Vector2()

func _ready():
	# connect to the NoteManager's "note_hit" signal. the NoteManager is in the root node
	get_tree().current_scene.get_node("NoteManager/NoteManager").connect("note_enter", self, "disable_movement")
	get_tree().current_scene.get_node("NoteManager/NoteManager").connect("note_exit", self, "enable_movement")

func disable_movement():
	can_move = false

func enable_movement():
	can_move = true

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
