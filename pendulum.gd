extends Node3D

var initialAngle: float = PI/4
var length1: float = 1
var length2: float = 1
var angle1: float = initialAngle
var angle2: float = 0
var angularVelocity1: float = 0
var angularVelocity2: float = 0
var angularAcceleration1: float = 0
var angularAcceleration2: float = 0
var gravity: float = 9.8

var time = 0
@onready var pendulum2 = $pendulum1Rod/pendulum2Center

func _ready() -> void:
	rotation.z = initialAngle

func _physics_process(delta: float) -> void:
	#time += delta * 10
	#rotation.z = sin(time)
	#pendulum2.rotation.z = sin(time)
	
	angularAcceleration1 = ((-gravity*delta/60) / length1) * sin(angle1)
	angularVelocity1 += angularAcceleration1
	angle1 += angularVelocity1
	rotation.z=angle1
	
	angularAcceleration2 = ((-gravity*delta/60) / length2) * sin(angle2)
	angularVelocity2 += angularAcceleration2
	angle2 += angularVelocity2
	pendulum2.rotation.z=angle2
