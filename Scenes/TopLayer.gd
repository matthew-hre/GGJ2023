extends Sprite

# if the player's y position is greater than the height of the BottomRightPillar CollisionBody, set our z position to -10000

func _process(delta):
	var player = get_node("/root/Game/Player")
	var collisions = get_node("StaticBody2D")


	# loop through all the CollisionAreas in the CollisionBody and find the closest one to the player
	var closest = null

	# if collisions has children, loop through them

	if collisions.get_child_count() <= 0:
		return

	for collision in collisions.get_children():
		if closest == null:
			closest = collision
		else:
			if abs(player.position.x - collision.position.x) < abs(player.position.x - closest.position.x):
				closest = collision
	
	if player.position.y < closest.position.y:
		z_index = 100
	else:
		z_index = 1

	delta = delta * 1
