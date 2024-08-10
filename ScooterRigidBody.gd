extends RigidBody2D

@export var wheels:Array[RigidBody2D]
var speed = 320000
var maxSpeed = 400
var rotateForce = 35000

var spriteChassis:Sprite2D
var spriteGuidonPhare:Sprite2D
var spriteGardeBoue:Sprite2D
@export var spriteCharacterParts:Array[Sprite2D]
var spritePipe:Sprite2D
var spriteFourche:Sprite2D
var spriteAccordeon:Sprite2D
var spriteDisqueFreinAvant:Sprite2D

var spriteAccordeonInitialOfsset:Vector2
var testPolygon2D:Polygon2D

var pointInter:Marker2D
var pointExter:Marker2D
var pointEntre:Marker2D

var distance_de_base_inter_exter:float
# Called when the node enters the scene tree for the first time.
func _ready():
	spriteChassis = $SpriteChassis
	spriteGuidonPhare = $SpriteChassis/GuidonPhare
	spriteGardeBoue = $FrontWheelPinJoint2D/FrontWheel/GardeBoue
	spritePipe = $SpriteChassis/PotEchappement
	spriteFourche = $SpriteChassis/Fourche
	spriteDisqueFreinAvant = $DisqueDeFrein
	spriteAccordeon = $SpriteChassis/Fourche/Accorderon
	
	pointInter=$SpriteChassis/PointInterieur
	pointExter=$SpriteChassis/PointExterieur
	pointEntre=$DisqueDeFrein/PointEntre
	
	var closestPoint = Geometry2D.get_closest_point_to_segment(pointEntre.global_position,pointInter.global_position,pointExter.global_position)
	var distance = pointInter.global_position.distance_to(closestPoint)
	
	distance_de_base_inter_exter = distance
	spriteAccordeonInitialOfsset = spriteAccordeon.offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$DisqueDeFrein.global_position=$FrontWheelPinJoint2D/FrontWheel.global_position
	$DisqueDeFrein2.global_position=$SpriteChassis/Fourche/Accorderon/BoutAccordeon.global_position
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("up"):
		for wheel in wheels:
			if wheel.angular_velocity < maxSpeed:
				wheel.apply_torque_impulse(speed * delta * 60)
	if Input.is_action_pressed("down"):
		for wheel in wheels:
			if wheel.angular_velocity > -maxSpeed:
				wheel.apply_torque_impulse(-speed * delta * 60)
	if Input.is_action_pressed("left"):
		apply_force(Vector2(-rotateForce,0),$ForceMarker.position)
	if Input.is_action_pressed("right"):
		apply_force(Vector2(rotateForce,0),$ForceMarker.position)
	vibrateParts()
	scaleAccordeon()
	
func vibrateParts():
	var frameVibrationForce = 10
	var mudgardVibrationForce = 3
	var frontWheelAngularVelocity = wheels[0].angular_velocity
	var backWheelAngularVelocity = wheels[1].angular_velocity
	if abs(frontWheelAngularVelocity) > 20 :
		var rand1 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand2 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand3 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		var rand4 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		spriteChassis.offset=Vector2(rand1,rand2)
		spriteGardeBoue.offset=Vector2(rand3,rand4)
		spritePipe.offset=Vector2(rand3*2,rand4)
		spriteGuidonPhare.offset=Vector2(rand1*0.8,rand2*0.8)
		for part:Sprite2D in spriteCharacterParts:
			part.offset=Vector2(rand1*0.8,rand2*0.8)

		spriteFourche.offset=Vector2(rand1/2,rand2/2)
		
		spriteAccordeon.offset=spriteAccordeonInitialOfsset+Vector2(rand1/2,rand2/2)
		
		spriteDisqueFreinAvant.offset=Vector2(rand1/2,rand2/2)
		$DisqueDeFrein2.offset=Vector2(rand1/2,rand2/2)
	else : 
		spriteChassis.offset=Vector2(0,0)
		spriteGardeBoue.offset=Vector2(0,0)
		spriteGuidonPhare.offset=Vector2(0,0)
		for part:Sprite2D in spriteCharacterParts:
			part.offset=Vector2(0,0)
		spriteGuidonPhare.offset=Vector2(0,0)
		spritePipe.offset=Vector2(0,0)
		spriteFourche.offset=Vector2(0,0)
		spriteAccordeon.offset=spriteAccordeonInitialOfsset
		spriteDisqueFreinAvant.offset=Vector2(0,0)
		$DisqueDeFrein2.offset=Vector2(0,0)
func scaleAccordeon():
	#var distance = pointInter.global_position.distance_to(pointExter.global_position)
	
	var closestPoint = Geometry2D.get_closest_point_to_segment(pointEntre.global_position,pointInter.global_position,pointExter.global_position)
	var distance = pointInter.global_position.distance_to(closestPoint)
	
	print("distance: ",distance)
	print("distance de base:",distance_de_base_inter_exter)
	var ratio = distance/distance_de_base_inter_exter
	print("scale y:",ratio)
	var y = ratio
	var difference = 1+(1-y)
	spriteAccordeon.scale=Vector2(difference,y)
