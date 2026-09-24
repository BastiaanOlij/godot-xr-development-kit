extends Node3D

## Our value has changed
signal changed(new_value: Vector2)

## Enable manipulating X axis
@export var enable_x: bool = true:
	set(value):
		enable_x = value
		if is_inside_tree():
			$AnimatableBody3D.enable_x = enable_x

## Enable manipulating Y axis
@export var enable_y: bool = true:
	set(value):
		enable_y = value
		if is_inside_tree():
			$AnimatableBody3D.enable_y = enable_y

## Maximum angle we can alter joystick
@export_range(0.0, 90.0, 1.0, "suffix:°", "radians_as_degrees") var max_angle: float = deg_to_rad(15.0):
	set(value):
		max_angle = value
		if is_inside_tree():
			$AnimatableBody3D.max_angle = value

## Value, treat this as read only!
@export var value: Vector2 = Vector2()


func _ready():
	$AnimatableBody3D.enable_x = enable_x
	$AnimatableBody3D.enable_y = enable_y
	$AnimatableBody3D.max_angle = max_angle


func _on_value_changed(new_value: Vector2):
	value = new_value
	changed.emit(value)
