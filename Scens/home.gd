extends Node2D

signal start_btn_press

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_down():
	emit_signal("start_btn_press")
	#get_tree().current_scene.start_game()
