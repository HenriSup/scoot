extends Sprite2D

var parent:Node2D
@export var marker:Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):  
	pass
	var angle_To_Rotation_point:float = global_position.angle_to_point(marker.global_position)
	#print("rotation:", angle_To_Rotation_point)
	look_at(marker.global_position)
	rotation += deg_to_rad(25)
	#rotation = -parent.rotation - angle_To_Rotation_point + deg_to_rad(-25)

