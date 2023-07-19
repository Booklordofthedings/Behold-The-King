extends Control

func start():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	
func exit():
	get_tree().quit()

func guide():
	get_tree().change_scene_to_file("res://Scenes/Guide.tscn")
	
func credits():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
	
func main():
	get_tree().change_scene_to_file("res://Scenes/Startmenu.tscn")
