extends Area2D

var in_area = false
var input_cooldown = false
var in_dialogue = false

@export var dia_name = ""
@export var dia_text = ""

@onready var dialogue_indicator_spirte = $DialogueIndicatorAnchor/DialogueIndicatorSprite
@onready var input_cooldown_timer = $InputCooldown

func _ready():
	dialogue_indicator_spirte.visible = false

func _input(event):
	if event.is_action_pressed("ui_select") and in_area and not input_cooldown and not in_dialogue:
		
		SignalBus.emit_signal("dialogue_box_visible", true)
		# SignalBus.emit_signal("dialogue_content", dia_name, dia_text)
		get_parent().emit_dialogue_signals()
		
		input_cooldown = true
		input_cooldown_timer.start()
		
		in_dialogue = true
		
	elif event.is_action_pressed("ui_select") and in_area and not input_cooldown and in_dialogue:
		SignalBus.emit_signal("dialogue_box_visible", false)
		
		in_dialogue = false

func _on_area_entered(area):
	in_area = true
	dialogue_indicator_spirte.visible = true
	# SignalBus.emit_signal("dialogue_box_visible", true)


func _on_area_exited(area):
	in_area = false
	dialogue_indicator_spirte.visible = false
	# SignalBus.emit_signal("dialogue_box_visible", false)


func _on_input_cooldown_timeout():
	input_cooldown = false
