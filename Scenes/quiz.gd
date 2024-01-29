extends Node2D


@onready var radioGroup: VBoxContainer = $Buttons/radioGroup;
@onready var questionText: Label = $UI/quizzView/questionText;

var rule_names = []

func _ready():
	
