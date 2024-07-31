extends RigidBody2D

@export var wheels:Array[RigidBody2D]
var speed = 120000
var maxSpeed = 200
var spriteChassis:Sprite2D
var spriteGuidonPhare:Sprite2D
var spriteGardeBoue:Sprite2D
var spriteCharacter:AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	spriteChassis = $SpriteChassis
	spriteGuidonPhare = $SpriteChassis/GuidonPhare
	spriteGardeBoue = $SpriteChassis/GardeBoue
	spriteCharacter = $SpriteChassis/Character
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
	vibrateParts()
	
func vibrateParts():
	var frameVibrationForce = 7
	var mudgardVibrationForce = 12
	var frontWheelAngularVelocity = wheels[0].angular_velocity
	var backWheelAngularVelocity = wheels[1].angular_velocity
	if abs(frontWheelAngularVelocity) > 50 :
		var rand1 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand2 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand3 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		var rand4 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		spriteChassis.offset=Vector2(rand1,rand2)
		spriteGardeBoue.offset=Vector2(rand3,rand4)
		spriteGuidonPhare.offset=Vector2(rand1/2,rand2/2)
		spriteCharacter.offset=Vector2(rand1/15,rand2/15)
	else : 
		spriteChassis.offset=Vector2(0,0)
		spriteGardeBoue.offset=Vector2(0,0)
		spriteGuidonPhare.offset=Vector2(0,0)
		spriteCharacter.offset=Vector2(0,0)
