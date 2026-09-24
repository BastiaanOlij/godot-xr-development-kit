extends Node3D

signal button_pressed
signal button_released

@export_flags_3d_physics var collision_mask: int = 0x0001

@onready var _area_3d: Area3D = $Area3D
@onready var _target: Node3D = $Target
@onready var _left_grab_point: GXDKGrabPoint = $Target/LeftGrabPoint
@onready var _right_grab_point: GXDKGrabPoint = $Target/RightGrabPoint

var _is_pressed: bool
var _closest: GXDKCollisionHand
var _start_position: Vector3
var _max_depress: float = 0.005

func is_pressed() -> bool:
	return _is_pressed

func _clear_closest():
	if _closest is GXDKCollisionHand:
		_closest.finger_poses = null
		_closest.remove_target_override(_target)
	_closest = null
	_target.transform = Transform3D()

func _set_closest(new_closest: GXDKCollisionHand):
	_closest = new_closest
	_start_position = global_transform.inverse() * _closest.get_tracked_transform().origin

	# Get our transform from our middle metaCarpal bone to our actual controller position
	var offset: Transform3D
	if _closest.hand == 0:
		offset = _left_grab_point.transform * _closest.get_bone_transform("LeftMiddleMetacarpal").inverse()
	else:
		offset = _right_grab_point.transform * _closest.get_bone_transform("RightMiddleMetacarpal").inverse()

	_closest.add_target_override(_target, 2, offset)
	# TODO trigger lerp from current location to new.

	# TODO make finger poses part of the override system as well!
	_closest.finger_poses = _left_grab_point.finger_poses

func _ready():
	_area_3d.collision_mask = collision_mask

func _process(_delta):
	# TODO: We should make our ghost hand have a detectable collision (area?) and filter on that.

	var new_closest: GXDKCollisionHand
	var distance: float = 99999.9
	for body: Node3D in _area_3d.get_overlapping_bodies():
		# For now we just detect collision hands, but we'll want other things in due time too.
		if not body is GXDKCollisionHand:
			continue

		var new_distance: float = (body.global_position - global_position).length()
		if new_distance < distance:
			distance = new_distance
			new_closest = body

	# If our hand moved to far away, don't use it
	if new_closest:
		var hand_distance: float = (new_closest.get_tracked_transform().origin - global_position).length()
		if hand_distance > 0.2:
			new_closest = null

	# Our closest is no longer our closest
	if _closest and (not new_closest or _closest != new_closest):
		_clear_closest()

	# We have a new closest hand
	if not _closest and new_closest:
		_set_closest(new_closest)

	if _closest:
		var local_position = global_transform.inverse() * _closest.get_tracked_transform().origin

		# 0 = not pressed, 1 = fully pressed
		var offset: float = clamp((_start_position.y - local_position.y) / _max_depress, 0.0, 1.0)
		var threshold: float = 0.4 if is_pressed else 0.6
		var new_is_pressed = offset > threshold
		if _is_pressed != new_is_pressed:
			_is_pressed = new_is_pressed
			if _is_pressed:
				button_pressed.emit()
			else:
				button_released.emit()

	elif _is_pressed:
		# And change state
		_is_pressed = false
		button_released.emit()
