extends CharacterBody2D

@export var wanted_text: String
@export_file var json_file: String

func ready():
	add_to_group("NPC")

func emit_dialogue_signals():
	print("signal emitted")
	SignalBus.emit_signal("dialogue_json", json_file, wanted_text)
