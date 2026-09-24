extends Node3D

# Todos:
# - Add button to start the game
# - Add button to initiate grab (should auto initiate when ending in furthest corner)
# - Add extend, grab, return 
# - Add move to shute and drop
# - Add returning logic
# - Make rope nice and all physicy
# - Add stuff to pick up!

enum GameState {
	NOT_STARTED,
	CAN_MOVE_GRABBER,
	GRAB_OBJECT,
	GOTO_SHUTE,
	DROP_OBJECT,
	RETURNING
}

@export var max_grabber_speed: float = 0.1

# Our game state, should change this to not started,
# so we need to press start 
var _game_state: GameState = GameState.CAN_MOVE_GRABBER

@onready var _joystick = $Interactables/Joystick
@onready var _grabber = $GrabberOrigin/Grabber

func _process(delta):
	if _game_state == GameState.CAN_MOVE_GRABBER:
		var joystick_value = _joystick.value * max_grabber_speed

		# We allow movement of the grabber only in one direction on each axis,
		# you can't return the grabber.
		_grabber.position.x = clamp(_grabber.position.x + min(0.0, joystick_value.x) * delta, -0.6, 0.0)
		_grabber.position.z = clamp(_grabber.position.z + min(0.0, joystick_value.y) * delta, -0.6, 0.0)
