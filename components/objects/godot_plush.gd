extends Node3D

@export_flags_3d_physics var collision_layer = 0x0001
@export_flags_3d_physics var collision_mask = 0x00FF

@onready var _root: RigidBody3D = $root
@onready var _skeleton: Skeleton3D = $root/Skeleton3D
@onready var _right_upper_arm: Node3D = $RightUpperArm/BoneTarget
@onready var _right_lower_arm: Node3D = $RightLowerArm/BoneTarget
@onready var _left_upper_arm: Node3D = $LeftUpperArm/BoneTarget
@onready var _left_lower_arm: Node3D = $LeftLowerArm/BoneTarget
@onready var _right_upper_leg: Node3D = $RightUpperLeg/BoneTarget
@onready var _left_upper_leg: Node3D = $LeftUpperLeg/BoneTarget

var _right_upper_arm_bone: int = -1
var _right_lower_arm_bone: int = -1
var _left_upper_arm_bone: int = -1
var _left_lower_arm_bone: int = -1
var _right_upper_leg_bone: int = -1
var _left_upper_leg_bone: int = -1

var _start_positions: Dictionary[RigidBody3D, Transform3D]

func _ready():
	for body: RigidBody3D in find_children("*", "RigidBody3D"):
		body.collision_layer = collision_layer
		body.collision_mask = collision_mask
		_start_positions[body] = body.global_transform

	_right_upper_arm_bone = _skeleton.find_bone("arm_stretch.r")
	_right_lower_arm_bone = _skeleton.find_bone("forearm_stretch.r")
	_left_upper_arm_bone = _skeleton.find_bone("arm_stretch.l")
	_left_lower_arm_bone = _skeleton.find_bone("forearm_stretch.l")
	_right_upper_leg_bone = _skeleton.find_bone("thigh_stretch.r")
	_left_upper_leg_bone = _skeleton.find_bone("thigh_stretch.l")

func _physics_process(_delta):
	# This should normally be in a SkeletonModifier node,
	# but this works too.
	var inv_skeleton_transform = _skeleton.global_transform.inverse()

	if _right_upper_arm_bone >= 0:
		_skeleton.set_bone_global_pose(_right_upper_arm_bone, inv_skeleton_transform * _right_upper_arm.global_transform)
	if _right_lower_arm_bone >= 0:
		_skeleton.set_bone_global_pose(_right_lower_arm_bone, inv_skeleton_transform * _right_lower_arm.global_transform)
	if _left_upper_arm_bone >= 0:
		_skeleton.set_bone_global_pose(_left_upper_arm_bone, inv_skeleton_transform * _left_upper_arm.global_transform)
	if _left_lower_arm_bone >= 0:
		_skeleton.set_bone_global_pose(_left_lower_arm_bone, inv_skeleton_transform * _left_lower_arm.global_transform)

	if _right_upper_leg_bone >= 0:
		_skeleton.set_bone_global_pose(_right_upper_leg_bone, inv_skeleton_transform * _right_upper_leg.global_transform)
	if _left_upper_leg_bone >= 0:
		_skeleton.set_bone_global_pose(_left_upper_leg_bone, inv_skeleton_transform * _left_upper_leg.global_transform)

	if _root.global_position.y < 0.15 and not GXDKPickup.picked_up_by(_root):
		if $RespawnTimer.time_left == 0.0:
			$RespawnTimer.start()
	elif $RespawnTimer.time_left > 0.0:
		$RespawnTimer.stop()


func _on_respawn_timer_timeout():
	for body in _start_positions:
		body.global_transform = _start_positions[body]
		body.linear_velocity = Vector3()
		body.angular_velocity = Vector3()
