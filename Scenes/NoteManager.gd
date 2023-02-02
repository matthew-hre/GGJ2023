extends Control

var file = null
var filepath = ""
var enabled = false
var text = ""
var wrap_width = 0
var current_line = 0

signal note_enter
signal note_exit

var font = load("res://Assets/Fonts/notefont.tres")

func _ready():
	if (filepath != ""):
		load_note()

	# connect to every note trigger
	for note in get_tree().get_nodes_in_group("NoteTrigger"):
		note.connect("player_entered", self, "trigger_note", [filepath])

	wrap_width = get_viewport_rect().size.x - 20
	current_line = 0
	$RichTextLabel.bbcode_text = text
	$RichTextLabel.get_child(0).modulate.a = 0
	$RichTextLabel.get_child(0).rect_size.x = 1

func _draw():
	if (enabled):
		draw_rect(Rect2(0, 0, get_viewport_rect().size.x, get_viewport_rect().size.y), Color(0, 0, 0, 1))

func _input(event):
	# in the player presses the down key, scroll down
	if event.is_action_pressed("down"):
		if current_line < $RichTextLabel.get_line_count() - 1:
			current_line += 1
			$RichTextLabel.scroll_to_line(current_line)
		$RichTextLabel.scroll_to_line(current_line)
	
	# if the player presses the up key, scroll up
	if event.is_action_pressed("up"):
		if current_line > 0:
			current_line -= 1
			$RichTextLabel.scroll_to_line(current_line)
		$RichTextLabel.scroll_to_line(current_line)
	
	# if the player presses enter or escape, close the note
	if event.is_action_pressed("enter") or event.is_action_pressed("escape"):
		enabled = false
		$RichTextLabel.bbcode_text = ""
		emit_signal("note_exit")
		update()

func load_note():
	# load the note
	print(filepath)

	file = File.new()
	file.open("Assets/notes/" + filepath + ".txt", File.READ)
	text = file.get_as_text()
	file.close()

	current_line = 0

	text += "\n\n[color=#ea323c]ENTER or ESC to close[/color]"

	$RichTextLabel.bbcode_text = text
	$RichTextLabel.scroll_to_line(current_line)

func trigger_note(new_filepath, other_thing):
	print(other_thing) # idk what this is but it's needed
	filepath = new_filepath
	load_note()
	enabled = true
	emit_signal("note_enter")
	update()
