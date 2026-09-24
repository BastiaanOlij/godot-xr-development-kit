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
	CAN_MOVE_GRABBER,
	LOWER_GRABBER,
	GRAB_OBJECT,
	RAISE_GRABBER,
	GOTO_SHUTE,
	DROP_OBJECT,
	RETURNING
}

@export var max_grabber_speed: float = 0.1

var _game_state: GameState = GameState.CAN_MOVE_GRABBER
var _lower_speed: float = 0.3
var _claw_speed: float = 1.0
var _horizontal_speed: float = 0.3

@onready var _joystick = $Interactables/Joystick
@onready var _grabber = $GrabberOrigin/Grabber

func _process(delta):
	if _game_state == GameState.CAN_MOVE_GRABBER:
		var joystick_value = _joystick.value * max_grabber_speed

		# We allow movement of the grabber only in one direction on each axis,
		# you can't return the grabber.
		_grabber.position.x = clamp(_grabber.position.x + min(0.0, joystick_value.x) * delta, -0.5, 0.0)
		_grabber.position.z = clamp(_grabber.position.z + min(0.0, joystick_value.y) * delta, -0.5, 0.0)

func _physics_process(delta):
	match _game_state:
		GameState.LOWER_GRABBER:
			# Slowly lower our grabber
			_grabber.length = min(0.6, _grabber.length + delta * _lower_speed)
			_grabber.open = min(1.0, _grabber.open + delta * _claw_speed)
			if _grabber.open == 1.0 and _grabber.length == 0.6:
				_game_state = GameState.GRAB_OBJECT
		GameState.GRAB_OBJECT:
			_grabber.open = max(0.0, _grabber.open - delta * _claw_speed)
			if _grabber.open == 0.0:
				_game_state = GameState.RAISE_GRABBER
		GameState.RAISE_GRABBER:
			# Slowly raise our grabber
			_grabber.length = max(0.0, _grabber.length - delta * _lower_speed)
			if _grabber.length == 0.0:
				_game_state = GameState.GOTO_SHUTE
		GameState.GOTO_SHUTE:
			_grabber.position.x = max(-0.5, _grabber.position.x - delta * _horizontal_speed)
			_grabber.position.z = min(0.0, _grabber.position.z + delta * _horizontal_speed)
			if _grabber.position == Vector3(-0.5, 0.0, 0.0):
				_game_state = GameState.DROP_OBJECT
		GameState.DROP_OBJECT:
			_grabber.open = min(1.0, _grabber.open + delta * _claw_speed)
			if _grabber.open == 1.0:
				_game_state = GameState.RETURNING
		GameState.RETURNING:
			_grabber.open = max(0.0, _grabber.open - delta * _claw_speed)
			_grabber.position.x = min(0.0, _grabber.position.x + delta * _horizontal_speed)
			_grabber.position.z = min(0.0, _grabber.position.z + delta * _horizontal_speed)
			if _grabber.open == 0 and _grabber.position == Vector3(0.0, 0.0, 0.0):
				_game_state = GameState.CAN_MOVE_GRABBER
		_:
			pass

func _on_grab_button_button_pressed():
	if _game_state == GameState.CAN_MOVE_GRABBER:
		_game_state = GameState.LOWER_GRABBER
