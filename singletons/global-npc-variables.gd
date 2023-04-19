extends Node

var npc_dictionary: Dictionary
var npc_dictionary_file = "res://npc/global-npc-variables.json"

func _ready():
	parse_json()

func parse_json():
	var file = npc_dictionary_file
	file = FileAccess.open(file, FileAccess.READ)
	npc_dictionary = JSON.parse_string(file.get_as_text())
