extends Control

var file = File.new()
var text = ""
var wrap_width = 0
var current_line = 0

var font = load("res://Assets/Fonts/notefont.tres")

func _ready():
	# set z index to 1000 so it's on top of everything
	
	file.open("res://Assets/notes/note1.txt", File.READ)
	text = file.get_as_text()
	file.close()

	wrap_width = get_viewport_rect().size.x - 20
	current_line = 0

func _draw():
	draw_rect(Rect2(0, 0, get_viewport_rect().size.x, get_viewport_rect().size.y), Color(0, 0, 0, 1))
	$RichTextLabel.bbcode_text = text
	$RichTextLabel.get_child(0).modulate.a = 0

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
