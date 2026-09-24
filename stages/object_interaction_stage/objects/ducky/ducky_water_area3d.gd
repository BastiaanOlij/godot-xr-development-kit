extends Area3D

@export var path: Path3D
@export var water_line: float = 0.48
@export_range(0.01, 10.00, 0.01, "suffix:m/s") var water_speed: float = 0.2
@export_range(0.01, 2.00, 0.01, "suffix:N") var water_strength: float = 0.1

func _physics_process(delta):
	var inv_path_transform: Transform3D
	if path:
		inv_path_transform = path.global_transform.inverse()

	# We are only detecting physics objects in layer 9
	# We have only placed our duckies in layer 9
	# Apply buoyancy to our duckies!
	for object: RigidBody3D in get_overlapping_bodies():
		# Calculate how far the midpoint of our ducky is under water
		# If:
		#   0.00  -> ducky is half under water (up to neck)
		#   0.025 -> ducky should be floating
		#   0.05  -> ducky is out of water
		#  -0.05  -> ducky fully under water
		var depth = object.global_position.y - water_line - global_position.y
		var factor = 1.0 - clamp(depth / 0.05, 0.0, 1.0)
		var up_force = Vector3(0.0, 20.0, 0.0) * factor
		object.apply_force(up_force, object.global_basis * Vector3(0.0, 0.05, 0.0))

		# Find out our closest point on our path to our ducky
		if path:
			var curve: Curve3D = path.curve
			var point: Vector3 = inv_path_transform * object.global_position
			var offset: float = curve.get_closest_offset(point)
			var t: Transform3D = path.global_transform * curve.sample_baked_with_rotation(offset)

			# Now use our orientation to determine a force to move the ducky along our path
			factor = (water_speed - object.linear_velocity.project(t.basis.z).length()) / water_speed
			object.apply_force(t.basis.z * factor * water_strength, object.global_basis * Vector3(0.1, 0.0, 0.0))
