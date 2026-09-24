extends RigidBody3D

@export_range(0.01, 1.00, 0.01, "suffix:m/s") var min_linear_velocity: float = 0.01
@export_range(1.0, 60.0, 0.1, "suffix:s") var wait_time: float = 5.0
var _respawn_timer: Timer


func _ready():
	_respawn_timer = Timer.new()
	_respawn_timer.wait_time = wait_time
	_respawn_timer.one_shot = true
	add_child(_respawn_timer, false, Node.INTERNAL_MODE_BACK)
	_respawn_timer.timeout.connect(_on_timeout)


# Picked up by a hand
func picked_up(_by: GXDKPickup):
	_respawn_timer.stop()


# Dropped by a hand
func dropped(_by: GXDKPickup):
	# If we're still being held by another hand, or are captured by a snapzone, ignore.
	if GXDKPickup.picked_up_by(self) or GXDKSnapZone.captured_by(self):
		return

	_respawn_timer.start()


# Captured by a snapzone
func captured(_by: GXDKSnapZone):
	_respawn_timer.stop()


# Released by a snapzone
func released(_by: GXDKSnapZone):
	# If we're still being held by another hand, or are captured by a snapzone, ignore.
	if GXDKPickup.picked_up_by(self) or GXDKSnapZone.captured_by(self):
		return

	_respawn_timer.start()


func _on_timeout():
	if linear_velocity.length() > min_linear_velocity:
		# Check again in another `wait_time` seconds..
		_respawn_timer.start()
		return

	# JIC reset velocities
	linear_velocity = Vector3()
	angular_velocity = Vector3()

	# Now move!
	var was_global_transform = global_transform
	if top_level:
		transform = get_parent().global_transform
	else:
		transform = Transform3D()

	var delta_transform = global_transform * was_global_transform.inverse()
	for snap_zone: GXDKSnapZone in find_children("*", "GXDKSnapZone", false):
		var captured_node: PhysicsBody3D = snap_zone.get_captured_node()
		if captured_node:
			captured_node.global_transform = delta_transform * captured_node.global_transform
