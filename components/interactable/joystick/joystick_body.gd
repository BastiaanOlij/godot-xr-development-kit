extends AnimatableBody3D

## Our value has changed
signal changed(new_value: Vector2)

## Enable manipulating X axis
@export var enable_x: bool = true

## Enable manipulating Y axis
@export var enable_y: bool = true

## Maximum angle we can alter joystick
@export_range(0.0, 90.0, 1.0, "suffix:°", "radians_as_degrees") var max_angle: float = deg_to_rad(15.0)


var start_position: Vector3


func picked_up(by: GXDKPickup):
	start_position = get_parent().global_transform.inverse() * by.get_controller_target().origin


func dropped(by: GXDKPickup):
	# Move joystick back to center.
	basis = Basis()
	changed.emit(Vector2(0.0, 0.0))


func _xr_custom_pickup_handler(pickup: GXDKPickup, delta: float, controller_target: Transform3D, _global_target: Transform3D) -> bool:
	var local_position = get_parent().global_transform.inverse() * controller_target.origin
	local_position -= start_position

	var x_angle: float = 0.0
	if enable_y:
		x_angle = -clamp(Vector2(0.0, 1.0).angle_to(Vector2(local_position.z, 0.1)), -max_angle, max_angle)

	var z_angle: float = 0.0
	if enable_x:
		z_angle = clamp(Vector2(0.0, 1.0).angle_to(Vector2(local_position.x, 0.1)), -max_angle, max_angle)
	
	rotation = Vector3(x_angle, 0.0, z_angle)

	changed.emit(Vector2(-z_angle / max_angle, x_angle / max_angle))

	return true
