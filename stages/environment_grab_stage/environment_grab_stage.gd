@tool
extends GXDKStageBase

## This is our environment grab demo stage, for now just a place holder.
## The idea here is to change this into a jungle room where the player
## can grab anything in the environment to propel forward.
##
## As such this demo does not use our GXDKCharacterBody3D node but instead
## combines our components with a rigidbody.

@export var head_height: float = 0.75

@onready var xr_origin: XROrigin3D = $CharacterBody3D/XROrigin3D
@onready var xr_locomotion_handler: GXDKLocomotionHandler = $CharacterBody3D/GXDKLocomotionHandler

## Called when user has requested pose recenter
func pose_recentered():
	# Implement on extended class
	var head_tracker: XRPositionalTracker = XRServer.get_tracker("head")
	if not head_tracker:
		return

	var pose: XRPose = head_tracker.get_pose("default")
	if not pose:
		return

	# We just want to center on our character body,
	# we ignore the direction we're looking at (for now).
	var pos: Vector3 = pose.get_adjusted_transform().origin
	pos.y -= head_height
	xr_origin.position = -pos


## This is called after the scene is loaded and added to our scene tree
func scene_loaded(user_data = null) -> void:
	super(user_data)

	pose_recentered()

	# For now force our friction to be low through our callback system.
	# TODO: I want to rewrite this so our locomotion handler always retrieves the object
	# we are standing on, and obtains info from that.
	xr_locomotion_handler.register_floor_friction_callback(_floor_friction_callback)


func _floor_friction_callback() -> float:
	return 0.1
