extends Node3D

var time = 0
@onready var pendulum2 = $pendulum1Rod/pendulum2Center

func _physics_process(delta: float) -> void:
	time += delta * 10
	rotation.z = sin(time)
	pendulum2.rotation.z = sin(time)
