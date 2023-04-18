extends Node

var dialogue_stage = "No Quests"

@export_file var json_file

func _ready():
	SignalBus.emit_signal("start_dialogue", json_file, dialogue_stage)
	# SignalBus.emit_signal("dialogue_json", json_file, dialogue_stage)
	

func _input(event):
	if event.is_action_pressed("ui_select"):
		SignalBus.emit_signal("next_dialogue")
