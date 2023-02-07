extends StaticBody2D

# if the player's y position is greater than the height of the BottomRightPillar CollisionBody, set our z position to -10000

func _process(delta):
	var player = get_node("/root/Game/Player")

	# if collisions has children, loop through them

	if get_child_count() <= 0:
		return

	for collision in get_children():
		if player.position.y < collision.position.y:
			collision.get_node("Sprite").z_index = 100
		else:
			collision.get_node("Sprite").z_index = 1

	delta = delta * 1
