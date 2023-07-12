extends Node

var save_config : ConfigFile

## Initial load and parse
func _ready():
	save_config = ConfigFile.new()
	var err = save_config.load("user://save")
	if err:
		return

## Read a value with the given string key
func read(key : String, default : Variant):
	return save_config.get_value("save", key, default)

## Write a key
func write(key : String, value : Variant):
	save_config.set_value("save",key,value)
	save_config.save("user://save")
	
## Reset the savefile
func reset():
	save_config.clear()
	save_config.save("user://save")
