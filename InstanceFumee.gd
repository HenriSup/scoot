extends Marker2D

var timerInstance:Timer
var timerInstance2:Timer
var smokeWheelAnimatedSprite:AnimatedSprite2D
var driftAnimatedSprite:AnimatedSprite2D
var shouldEmit:bool
var parent:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	parent=get_parent()
	timerInstance=$Timer
	timerInstance2=$Timer2
	smokeWheelAnimatedSprite=$SmokeWheel
	driftAnimatedSprite=$Drift
	shouldEmit=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$SmokeWheel.rotation=0
	#$Drift.rotation=0
	if timerInstance.is_stopped() && shouldEmit:
		var newSmoke:AnimatedSprite2D = smokeWheelAnimatedSprite.duplicate()
		newSmoke.global_position= $Drift.global_position+Vector2(-650,-490)
		newSmoke.show()
		newSmoke.rotation=0
		var newScale = randf_range(8,8)
		newSmoke.scale.x=newScale
		newSmoke.scale.y=newScale
		get_tree().root.add_child(newSmoke)
		timerInstance.start()
	if timerInstance2.is_stopped() && shouldEmit:
		var newDrift:AnimatedSprite2D = driftAnimatedSprite.duplicate()
		newDrift.global_position= $Drift.global_position+Vector2(20,0)
		newDrift.show()
		newDrift.rotation=0
		var newScale2 = randf_range(1,1.5)
		newDrift.scale.x=newScale2
		newDrift.scale.y=newScale2
		get_tree().root.add_child(newDrift)
		timerInstance2.start()
	pass

func change_should_emit_value(value:bool):
	shouldEmit = value
