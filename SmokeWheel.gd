extends AnimatedSprite2D

var parent 
# Called when the node enters the scene tree for the first time.
func _ready():
	parent=get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation = -parent.rotation
	pass
