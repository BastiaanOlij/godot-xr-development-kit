@tool
extends Node3D

@export_range(0.1, 0.9, 0.01) var length: float = 0.1:
	set(value):
		length  = value
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

func _update_length():
	$Rope.position.y = length * -0.5
	$Rope.scale.y = length
	$Claw.position.y = -length


func _update_open():
	var x_angle = (1.0 + open) * 0.25 * PI
	claw01.rotation = Vector3(x_angle, 0.0, 0.0)
	claw02.rotation = Vector3(x_angle, TAU * 0.33333, 0.0)
	claw03.rotation = Vector3(x_angle, TAU * 0.66666, 0.0)

func _ready():
	_update_length()
	_update_open()
