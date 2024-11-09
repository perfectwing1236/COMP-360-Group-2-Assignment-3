extends Node3D

var gravity: float = 9.8

@onready var pendulum2 = $pendulum1Rod/pendulum2Center

const init_angle_1 = Vector3(PI/4, 0, PI/4)
const init_angle_2 = Vector3(PI/3, 0, PI/4)
#const init_angle_1 = Vector3(PI + 0.1, 0, PI + 0.1) ## Exceeds PI, will trigger the assert
#const init_angle_2 = Vector3(-PI - 0.1, 0, PI + 0.1) ## Less than -PI, will trigger the assert

var velocity = Vector3(0, 0, 0)
var velocity2 = Vector3(0, 0, 0)

func _ready() -> void:
	rotation = init_angle_1
	pendulum2.rotation = init_angle_2
	
	## Assert initial rotations are within expected range.
	#assert(rotation.z >= -PI and rotation.z <= PI, "Initial Angle 1 is out of bounds!")
	#assert(pendulum2.rotation.z >= -PI and pendulum2.rotation.z <= PI, "Initial Angle 2 is out of bounds!")

func _physics_process(_delta: float) -> void:
	
	## Prints initial rotation and velocity values for the double pendulum
	#print("Initial rotation 1: ", rotation, " | Initial rotation 2: ", pendulum2.rotation)
	#print("Initial velocity 1: ", velocity, " | Intial velocity 2: ", velocity2)

	velocity.x -= sign(global_position.z - ($pendulum1Ball.global_position.z + $pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.z)/2) / (10000.0 / gravity)
	velocity.z += sign(global_position.x - ($pendulum1Ball.global_position.x + $pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.x)/2) / (10000.0 / gravity)
	rotation += velocity
	
	## Log updated rotation and velocity values after applying changes
	#print("Updated rotation for 1: ", rotation, " | velocity 1: ", velocity)
	
	velocity2.x += sign($pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.z - (global_position.z + $pendulum1Ball.global_position.z)/2) / (10000.0 / gravity)
	velocity2.z -= sign($pendulum1Rod/pendulum2Center/pendulum2Ball.global_position.x - (global_position.x + $pendulum1Ball.global_position.x)/2) / (10000.0 / gravity)
	pendulum2.rotation += velocity2
	
	## After updating, assert angles again to ensure stability. If not within bounds then animation will stop.
	#assert(rotation.z >= -PI and rotation.z <= PI, "Angle 1 is beyond the specified range!")
	#assert(pendulum2.rotation.z >= -PI and pendulum2.rotation.z <= PI, "Angle 2 is beyond the specified range!")
	
	## Log updated values for pendulum2 rotation and velocity2 after applying changes
	#print("Updated rotation for 2: ", pendulum2.rotation, " | velocity 2: ", velocity2)
