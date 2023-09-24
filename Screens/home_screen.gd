extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_button_down():
	print("BUTTON PRESSED")
	TransitionLayer.change_scene("res://Screens/player_screen.tscn")


func _on_load_button_button_down():
	TransitionLayer.change_scene("res://Screens/player_screen.tscn")


func _on_start_button_button_up():
	print("BUTTON PRESSED")
	TransitionLayer.change_scene("res://Screens/player_screen.tscn")
