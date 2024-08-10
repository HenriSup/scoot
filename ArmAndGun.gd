extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	if (Input.is_action_just_pressed("clique gauche")):
		var rand = randf_range(0.8,1.2)
		if(animation!="shooting"):
			play("shooting")
			$AudioStreamPlayer.pitch_scale=rand
			$AudioStreamPlayer.play()
		else:
			frame=0
			$AudioStreamPlayer.pitch_scale=rand
			$AudioStreamPlayer.play()
	if (animation=="shooting" && frame==4):
		play("idle")
	pass
