extends Node2D


@onready var radioGroup: VBoxContainer = $UI/quizzView/questionText/radioGroup;
@onready var questionTextLabel: Label = $UI/quizzView/questionText;

var ruleNames = []
var difficulty = "★"
var chosenRule = ""
var chosenQuestionText = ""

func _ready():
	createQuestion()
	setButtons()

func createQuestion():
	for rule in StaticData.itemData[difficulty]:
		ruleNames.append(rule.replace("%", " "))
	
	var rng = RandomNumberGenerator.new()
	var i = rng.randi_range(0,len(ruleNames) - 1)

	chosenRule = ruleNames[i]
	
	var questionsText = []
	var ruleList = StaticData.itemData[difficulty][chosenRule.replace(" ", "%")]["ruleText"]
	for index in ruleList.get_slice_count("µ"):
		questionsText.append(ruleList.get_slice("µ", index))

	
	i = rng.randi_range(0,len(questionsText) - 1)
	chosenQuestionText = questionsText[i].replace(chosenRule.get_slice(" ", 1), "███████")
	questionTextLabel.set_text('"'+chosenQuestionText+'"')
	
func setButtons():
	ruleNames.shuffle()
	for ruleName in ruleNames:
		var radio: CheckBox = CheckBox.new()
		radio.set_text(ruleName)
		radio.add_theme_color_override("font_color", Color.BLACK)
		radio.add_theme_color_override("font_hover_color", Color.DIM_GRAY)
		radio.add_theme_color_override("font_hover_pressed_color", Color.DIM_GRAY)
		radio.add_theme_color_override("font_pressed_color", Color.WEB_GRAY)
		radio.add_theme_color_override("font_focus_color", Color.BLACK)
		radio.add_theme_constant_override("check_v_offset", 1)
		radio.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		radio.button_down.connect(Callable(self, "onCheckboxChecked"))
		radioGroup.add_child(radio)

func onCheckboxChecked():
	var radioButtons = radioGroup.get_children()
	for radio in radioButtons:
		print(radio)
		radio.button_pressed = false
