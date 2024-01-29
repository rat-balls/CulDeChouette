extends Node

var itemData = {}

var data_filePath = "res://Data/staticData.json"

func _ready():
	itemData = loadJson(data_filePath)

func loadJson(filePath: String):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var json_string = dataFile.get_as_text().get_slice("= ", 1)
		var json = JSON.new()
		var error = json.parse(json_string)
		if error == OK:
			if json.data is Dictionary:
				return json.data
			else:
				print("Error occurred during JSON read")
		else:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	else:
		print("File doesn't exist.")
