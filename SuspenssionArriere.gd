extends Sprite2D

var parent:Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):  
	pass
	rotation = -parent.rotation

