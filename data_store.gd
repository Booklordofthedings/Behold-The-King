extends Node


var data_store = {
	
}

## Read a value with the given string key
func read(key : String):
	pass

## Write a key
func write(key : String, value):
	var t = FileAccess.open("user://sdasdsad", FileAccess.WRITE)
