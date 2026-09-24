@tool
extends Node3D

signal claw_collided

@export_range(0.0, 0.9, 0.01) var length: float = 0.0:
	set(value):
		length = value
		adj_length = length + 0.03
		if is_inside_tree():
			_update_length()


@export_range(0.0, 1.0, 0.01) var open: float = 0.0:
	set(value):
		open = value
		if is_inside_tree():
			_update_open()

@onready var claw01: Node3D = $Claw/Claw01
@onready var claw02: Node3D = $Claw/Claw02
@onready var claw03: Node3D = $Claw/Claw03

var adj_length: float

func _update_length():
	$Rope.position.y = adj_length * -0.5
	$Rope.scale.y = adj_length
	if Engine.is_editor_hint():
		$ClawAnchor.position.y = -adj_length
		$Chain01.position.y = -adj_length - 0.03
		$Chain02.position.y = -adj_length - 0.08
		$Chain03.position.y = -adj_length - 0.13
		$Claw.position.y = -adj_length - 0.16


func _update_open():
	var x_angle = (2.0 + open) * 0.15 * PI
	claw01.rotation = Vector3(x_angle, 0.0, 0.0)
	claw02.rotation = Vector3(x_angle, TAU * 0.33333, 0.0)
	claw03.rotation = Vector3(x_angle, TAU * 0.66666, 0.0)

func _ready():
	_update_length()
	_update_open()

	if Engine.is_editor_hint():
		return

	$ClawAnchor.top_level = true
	$Chain01.top_level = true
	$Chain02.top_level = true
	$Chain03.top_level = true
	$Claw.top_level = true

func _physics_process(_delta):
	if Engine.is_editor_hint():
		return

	$ClawAnchor.position = global_transform * Vector3(0.0, -adj_length, 0.0)

func _on_claw_body_entered(_body):
	claw_collided.emit()
