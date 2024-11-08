extends Node3D

#var initialAngle: float = PI/4
#var length1: float = 1
#var length2: float = 1
#var angle1: float = initialAngle
#var angle2: float = 0
#var angularVelocity1: float = 0
#var angularVelocity2: float = 0
#var angularAcceleration1: float = 0
#var angularAcceleration2: float = 0
var gravity: float = 9.8

@onready var pendulum2 = $pendulum1Rod/pendulum2Center

const init_angle_1 = Vector3(PI/4, 0, PI/4)
const init_angle_2 = Vector3(PI/3, 0, PI/4)
#const init_angle_1 = Vector3(PI + 0.1, 0, PI + 0.1) # Exceeds PI, will trigger the assert
#const init_angle_2 = Vector3(-PI - 0.1, 0, PI + 0.1) # Less than -PI, will trigger the assert

var velocity = Vector3(0, 0, 0)
var velocity2 = Vector3(0, 0, 0)

func _ready() -> void:
	#rotation.z = initialAngle
	rotation = init_angle_1
	pendulum2.rotation = init_angle_2
	
	# Assert initial rotations are within expected range.
	#assert(rotation.z >= -PI and rotation.z <= PI, "Initial Angle 1 is out of bounds!")
	#assert(pendulum2.rotation.z >= -PI and pendulum2.rotation.z <= PI, "Initial Angle 2 is out of bounds!")

func _physics_process(_delta: float) -> void:
	
	#angularAcceleration1 = ((-gravity*delta/60) / length1) * sin(angle1)
	#angularVelocity1 += angularAcceleration1
	#angle1 += angularVelocity1
	#rotation.z=angle1
	
	#angularAcceleration2 = ((-gravity*delta/60) / length2) * sin(angle2)
	#angularVelocity2 += angularAcceleration2
	#angle2 += angularVelocity2
	#pendulum2.rotation.z=angle2

	velocity.x -= sign(global_position.z - ($pendulum1Ball.global_position.z + $pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.z)/2) / (10000.0 / gravity)
	velocity.z += sign(global_position.x - ($pendulum1Ball.global_position.x + $pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.x)/2) / (10000.0 / gravity)
	rotation += velocity
	velocity2.x += sign($pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.z - (global_position.z + $pendulum1Ball.global_position.z)/2) / (10000.0 / gravity)
	velocity2.z -= sign($pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.x - (global_position.x + $pendulum1Ball.global_position.x)/2) / (10000.0 / gravity)
	pendulum2.rotation += velocity2
	
	# After updating, assert angles again to ensure stability. If not within bounds then animation will stop.
	#assert(rotation.z >= -PI and rotation.z <= PI, "Angle 1 is beyond the specified range!")
	#assert(pendulum2.rotation.z >= -PI and pendulum2.rotation.z <= PI, "Angle 2 is beyond the specified range!")
