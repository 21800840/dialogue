extends CharacterBody2D

@export var speed = 800

func _physics_process(delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = speed * velocity.normalized()
	
	move_and_slide()
