extends RigidBody2D

var pointInter:Marker2D
var pointExter:Marker2D
var accordeon:Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pointInter=$PointInterieur
	pointExter=$PinJoint2D/RoueRigidBody/PointExterieur
	accordeon=$Accorderon
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	var distance = pointInter.global_position.distance_to(pointExter.global_position)

	var y = distance/accordeon.texture.get_size().y
	var difference = 1+(1-y)
	$Accorderon.scale=Vector2(difference,y)
	pass
