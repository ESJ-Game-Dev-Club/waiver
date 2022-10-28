extends Node


func _input(event):
	if (event.is_action_pressed("fullscreen_toggle")):
		OS.set_window_fullscreen(!OS.window_fullscreen)
