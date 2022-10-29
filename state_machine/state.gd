class_name State
extends Node2D

# all of these are functions that the state machine runs
# this allows only one state to be active

func enter(): # kinda like _ready() but way cooler 
	pass

func exit(): # run when the state deactivates
	pass

func unhandled_input(_event): # run when the state receives input from the player
	pass

func physics_process(_delta): # run every physics process
	pass
