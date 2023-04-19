extends CharacterBody2D

# NPC variables.
var dialogue_stage = "Options"

@export_file var json_file

func ready():
	add_to_group("NPC")

func emit_dialogue_signals():
	# SignalBus.emit_signal("dialogue_json", json_file, wanted_text)
	pass

func get_dialogue_stage():
	return dialogue_stage

func set_dialogue_stage(new_dialogue_stage):
	dialogue_stage = new_dialogue_stage

func get_json_file():
	return json_file

func set_json_file(new_json_file):
	json_file = new_json_file
