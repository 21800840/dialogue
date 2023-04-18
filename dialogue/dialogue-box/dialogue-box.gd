extends CanvasLayer

var parsed_file: Dictionary
var current_stage = 0
var current_stage_int_to_str = str(current_stage)
var stage_size
var dia_stage # DO NOT RENAME IT TO DIALOGUE_STAGE

@onready var just_dialogue = $JustDialogue
@onready var just_dialogue_name = $JustDialogue/NameLabel
@onready var just_dialogue_text = $JustDialogue/TextLabel
@onready var dialogue_with_2_options = $DialogueWith2Options
@onready var dialogue_with_2_options_name = $DialogueWith2Options/NameLabel
@onready var dialogue_with_2_options_text = $DialogueWith2Options/TextLabel
@onready var dialogue_with_2_options_option_1 = $DialogueWith2Options/Option1
@onready var dialogue_with_2_options_option_2 = $DialogueWith2Options/Option2

func _ready():
	SignalBus.connect("start_dialogue", decide_dialogue_style)
	SignalBus.connect("dialogue_content", dialogue_content)
	SignalBus.connect("dialogue_json", parse_json)
	SignalBus.connect("next_dialogue", next_dialogue)

func dialogue_box_visible(set_visible):
	just_dialogue.visible = set_visible

func dialogue_content(set_name, set_text):
	just_dialogue_name.text = set_name
	just_dialogue_text.text = set_text

func parse_json(json_file, dialogue_stage):
	# DO NOT CHANGE FROM DIA_STAGE OR IT WONT KNOW WHICH DIALOGUE_STAGE VALUE SHOULD BE ASSIGNED
	dia_stage = dialogue_stage
	
	# Parsing json
	var file = json_file
	file = FileAccess.open(file, FileAccess.READ)
	parsed_file = JSON.parse_string(file.get_as_text())
	
	# Set current stage and convert to string
	current_stage += 1
	current_stage_int_to_str = str(current_stage)
	
	# Get size of current dialogue stage
	stage_size = parsed_file[dia_stage].size()
	
	# print(dia_stage)
	
	just_dialogue_name.text = parsed_file[dia_stage][current_stage_int_to_str]["name"]
	just_dialogue_text.text = parsed_file[dia_stage][current_stage_int_to_str]["text"]
	
	if current_stage <= stage_size and Input.is_action_just_pressed("ui_select"):
		
		
		# Put parsed info into the text labels
		just_dialogue_name.text = parsed_file[dia_stage][current_stage_int_to_str]["name"]
		just_dialogue_text.text = parsed_file[dia_stage][current_stage_int_to_str]["text"]
		
		current_stage += 1

func next_dialogue():
	if current_stage < stage_size:
		current_stage += 1
		
		current_stage_int_to_str = str(current_stage)
		
		# print("dia_stage = " + dia_stage)
		# print("current_stage_int_to_str = " + current_stage_int_to_str)
		
		just_dialogue_name.text = parsed_file[dia_stage][current_stage_int_to_str]["name"]
		just_dialogue_text.text = parsed_file[dia_stage][current_stage_int_to_str]["text"]
	else:
		just_dialogue_name.text = "NPC"
		just_dialogue_text.text = "No more dialogue"
		
		end_just_dialogue()
		
func start_just_dialogue():
	# Pause tree and make visible.
	# get_tree().paused = false
	just_dialogue.visible = true
	
	# Reset variables to default state
	current_stage = 0
	current_stage_int_to_str = str(current_stage)

func end_just_dialogue():
	just_dialogue.visible = false
	get_tree().paused = false
	
func decide_dialogue_style(json_file, dialogue_stage):
	parse_json(json_file, dialogue_stage)
	if int(parsed_file[dia_stage][current_stage_int_to_str]["options"]) >= 1:
		dialogue_with_2_options.visible = true
	else:
		just_dialogue.visible = true
