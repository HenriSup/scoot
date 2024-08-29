extends RigidBody2D

@export var wheels:Array[RigidBody2D]
@export var spriteWaveShaders:Array[Sprite2D]
@export var spriteWaveShadersValues:Array[float]
var speed = 320000
var maxSpeed = 400
var rotateForce = 3500000

var spriteChassis:Sprite2D
var spriteGuidonPhare:Sprite2D
var spriteGuidonPhareInitialPosition:Vector2

var spriteGardeBoue:Sprite2D
@export var spriteCharacterParts:Array[Sprite2D]
var spriteMouth:AnimatedSprite2D
var spritePipe:Sprite2D
var spriteFourche:Sprite2D
var spriteAccordeon:Sprite2D
var spriteDisqueFreinAvant:Sprite2D

var polygonBras:Polygon2D
var polygonBrasInitialOfsset:Vector2
var mancheBras:Sprite2D
var mancheBrasInitialOfsset:Vector2
var polygonAvantBras:Polygon2D
var polygonAvantBrasInitialOfsset:Vector2
var polygonMain:Polygon2D
var polygonMainInitialOfsset:Vector2

var polygonBrasGauche:Polygon2D
var polygonBrasGaucheInitialOfsset:Vector2
var mancheBrasGauche:Sprite2D
var mancheBrasGaucheInitialOfsset:Vector2
var polygonAvantBrasGauche:Polygon2D
var polygonAvantBrasGaucheInitialOfsset:Vector2
var polygonMainGauche:Polygon2D
var polygonMainGaucheInitialOfsset:Vector2



var spriteAccordeonInitialOfsset:Vector2
var testPolygon2D:Polygon2D

var pointInter:Marker2D
var pointExter:Marker2D
var pointEntre:Marker2D

var mainTarget:Node2D
var mainTargetOriginalPosition:Vector2

var distance_de_base_inter_exter:float

var offsetPhare:float = 0
var maxOffsetPhare:float = 10
var mainMaxRotate:float = 15
var mainInitialRotation:float
var mainPolygon:Polygon2D
var mainRotate:float = 0

@onready var mouth:AnimatedSprite2D=$SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/Bouche
@onready var eye:AnimatedSprite2D=$SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/Yeux
@onready var mouthTimer:Timer=$SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/MouthTimer
@onready var eyeTimer:Timer=$SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/EyeTimer
@onready var eyeAnimationPlayer:AnimationPlayer=$SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/EyeAnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	spriteChassis = $SpriteChassis
	spriteGuidonPhare = $SpriteChassis/GuidonPhare
	spriteGuidonPhareInitialPosition = spriteGuidonPhare.position
	spriteMouth = $SpriteChassis/Marcello/TorsoRigidBody2D2/RigidBody2D/Tete/Bouche
	spriteGardeBoue = $FrontWheelPinJoint2D/FrontWheel/GardeBoue
	spritePipe = $SpriteChassis/PotEchappement
	spriteFourche = $SpriteChassis/Fourche
	spriteDisqueFreinAvant = $DisqueDeFrein
	spriteAccordeon = $SpriteChassis/Fourche/Accorderon
	
	polygonBras=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/Bras
	mancheBras=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/Bras/MancheBras
	polygonAvantBras=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/AvantBras
	polygonMain=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/Main
	
	polygonBrasGauche=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasGauchePolygones/Bras
	mancheBrasGauche=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasGauchePolygones/Bras/MancheBras
	polygonAvantBrasGauche=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasGauchePolygones/AvantBras
	polygonMainGauche=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasGauchePolygones/Main

	mainPolygon=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/Main
	polygonBrasInitialOfsset=polygonBras.offset
	mancheBrasInitialOfsset=mancheBras.offset
	polygonAvantBrasInitialOfsset=polygonAvantBras.offset
	polygonMainInitialOfsset=polygonMain.offset
	
	polygonBrasGaucheInitialOfsset=polygonBrasGauche.offset
	mancheBrasGaucheInitialOfsset=mancheBrasGauche.offset
	polygonAvantBrasGaucheInitialOfsset=polygonAvantBrasGauche.offset
	polygonMainGaucheInitialOfsset=polygonMainGauche.offset

	
	
	
	pointInter=$SpriteChassis/PointInterieur
	pointExter=$SpriteChassis/PointExterieur
	pointEntre=$DisqueDeFrein/PointEntre
	
	mainTarget=$SpriteChassis/GuidonPhare/MainTarget
	mainTargetOriginalPosition=mainTarget.position
	mainInitialRotation=$SpriteChassis/Marcello/TorsoRigidBody2D2/BrasDroitPolygones/Main.rotation_degrees
	mainRotate=mainInitialRotation
	var closestPoint = Geometry2D.get_closest_point_to_segment(pointEntre.global_position,pointInter.global_position,pointExter.global_position)
	var distance = pointInter.global_position.distance_to(closestPoint)
	
	distance_de_base_inter_exter = distance
	spriteAccordeonInitialOfsset = spriteAccordeon.offset
	$BackWheelPinJoint2D2/BackWheel.contact_monitor=true
	$BackWheelPinJoint2D2/BackWheel.max_contacts_reported=1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$DisqueDeFrein.global_position=$FrontWheelPinJoint2D/FrontWheel.global_position
	$DisqueDeFrein2.global_position=$SpriteChassis/Fourche/Accorderon/BoutAccordeon.global_position
	print("scoot lineaspeed:",linear_velocity)
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("up"):
		$GPUParticles2D.amount_ratio=1
		offsetPhare-=5
		offsetPhare = clamp(offsetPhare, -maxOffsetPhare , maxOffsetPhare)
		mainRotate-=6
		mainRotate = clamp(mainRotate, -mainMaxRotate+mainInitialRotation, mainMaxRotate+mainInitialRotation)
		for wheel in wheels:
			if wheel.angular_velocity < maxSpeed:
				wheel.apply_torque_impulse(speed * delta * 60)
		
		if $BackWheelPinJoint2D2/BackWheel.get_contact_count()>=1:
			$BackWheelPinJoint2D2/SmokeEmiter.change_should_emit_value(true)
		else:
			$BackWheelPinJoint2D2/SmokeEmiter.change_should_emit_value(false)
	else:
		$BackWheelPinJoint2D2/SmokeEmiter.change_should_emit_value(false)
		$GPUParticles2D.amount_ratio=0
	if Input.is_action_pressed("down"):
		offsetPhare+=10
		offsetPhare = clamp(offsetPhare, -maxOffsetPhare , maxOffsetPhare)
		mainRotate+=3
		mainRotate = clamp(mainRotate, -mainMaxRotate+mainInitialRotation, mainMaxRotate+mainInitialRotation)
		for wheel in wheels:
			if wheel.angular_velocity > -maxSpeed:
				wheel.apply_torque_impulse(-speed * delta * 60)
	if Input.is_action_pressed("left"):
		apply_force(Vector2(-rotateForce * delta ,0),$ForceMarker.position)
	if Input.is_action_pressed("right"):
		apply_force(Vector2(rotateForce * delta,0),$ForceMarker.position)
	

	spriteGuidonPhare.position.x = spriteGuidonPhareInitialPosition.x + offsetPhare*0.3	
	mainTarget.position.x = mainTargetOriginalPosition.x + offsetPhare
	mainPolygon.rotation_degrees=mainRotate

	vibrateParts()
	scaleAccordeon()
	animateWaveShaders()

func animateWaveShaders():
	if (linear_velocity.x>50):
		var ratio = linear_velocity.x/2500
		ratio = clampf(ratio,0,1)
		var i = 0
		for sprite in spriteWaveShaders:
			sprite.material.set_shader_parameter("force",spriteWaveShadersValues[i]*ratio)
			i+=1
	else : 
		for sprite in spriteWaveShaders:
			sprite.material.set_shader_parameter("force",0)
	pass

func vibrateParts():
	var frameVibrationForce = 5
	var mudgardVibrationForce = 3
	var frontWheelAngularVelocity = wheels[0].angular_velocity
	#var backWheelAngularVelocity = wheels[1].angular_velocity
	if abs(frontWheelAngularVelocity) > 20 :
		var rand1 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand2 = randf_range(-1*frameVibrationForce,1*frameVibrationForce)
		var rand3 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		var rand4 = randf_range(-1*mudgardVibrationForce,1*mudgardVibrationForce)
		spriteChassis.offset=Vector2(rand1,rand2)
		spriteGardeBoue.offset=Vector2(rand3,rand4)
		spritePipe.offset=Vector2(rand3*2,rand4)
		spriteGuidonPhare.offset=Vector2(rand1*0.8,rand2*0.8)
		
		polygonBras.offset=polygonBrasInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		polygonBrasGauche.offset=polygonBrasGaucheInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		mancheBras.offset=mancheBrasInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		mancheBrasGauche.offset=mancheBrasGaucheInitialOfsset+Vector2(rand1*0.8,rand2*0.8)

		polygonAvantBras.offset=polygonAvantBrasInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		polygonMain.offset=polygonMainInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		
		polygonAvantBrasGauche.offset=polygonAvantBrasGaucheInitialOfsset+Vector2(rand1*0.8,rand2*0.8)
		polygonMainGauche.offset=polygonMainGaucheInitialOfsset+Vector2(rand1*0.8,rand2*0.8)

		
		#mainTarget.position=mainTargetOriginalPosition+(Vector2(rand1*0.8,rand2*0.8))
		
		
		for part:Sprite2D in spriteCharacterParts:
			part.offset=Vector2(rand1*0.8,rand2*0.8)
		spriteMouth.offset=Vector2(rand1*0.8,rand2*0.8)
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
		spriteMouth.offset=Vector2(0,0)
		spriteGuidonPhare.offset=Vector2(0,0)
		
		polygonBras.offset=polygonBrasInitialOfsset
		mancheBras.offset=mancheBrasInitialOfsset

		polygonAvantBras.offset=polygonAvantBrasInitialOfsset
		polygonMain.offset=polygonMainInitialOfsset

		#mainTarget.positi
		#mainTarget.position=mainTargetOriginalPosition
		
		spritePipe.offset=Vector2(0,0)
		spriteFourche.offset=Vector2(0,0)
		spriteAccordeon.offset=spriteAccordeonInitialOfsset
		spriteDisqueFreinAvant.offset=Vector2(0,0)
		$DisqueDeFrein2.offset=Vector2(0,0)
func scaleAccordeon():
	#var distance = pointInter.global_position.distance_to(pointExter.global_position)
	
	var closestPoint = Geometry2D.get_closest_point_to_segment(pointEntre.global_position,pointInter.global_position,pointExter.global_position)
	var distance = pointInter.global_position.distance_to(closestPoint)
	var ratio = distance/distance_de_base_inter_exter
	var y = ratio
	var difference = 1+(1-y)
	spriteAccordeon.scale=Vector2(difference,y)
	if ratio<=0.87:
		mouth.frame=3
		eyeAnimationPlayer.play("ferme")
		var alea = randf_range(0.4,0.6)
		eyeTimer.start(alea)
		mouthTimer.start(alea)
	elif mouthTimer.is_stopped():
		mouth.frame=0
	if eyeTimer.is_stopped() && eyeAnimationPlayer.current_animation=="ferme":
		eyeAnimationPlayer.play("ouvert")
	if eyeAnimationPlayer.current_animation!="cligne1" && eyeAnimationPlayer.current_animation!="ferme" && eyeTimer.is_stopped():
		eyeAnimationPlayer.play("cligne1")
		eyeTimer.start(randf_range(2,7))
