extends RigidBody2D

@export var wheels:Array[RigidBody2D]
var speed = 60000
var maxSpeed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("right"):
		for wheel in wheels:
			if wheel.angular_velocity < maxSpeed:
				wheel.apply_torque_impulse(speed * delta * 60)
	if Input.is_action_pressed("left"):
		for wheel in wheels:
			if wheel.angular_velocity > -maxSpeed:
				wheel.apply_torque_impulse(-speed * delta * 60)
