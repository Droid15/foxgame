extends Node2D

@export var slime_scens: PackedScene
@export var create_timer: Timer
@export var score: int = 0
@export var score_label: Label
@export var game_over_lable: Label
@export var level: int = 1

signal level_up(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("/root/Bgm").play()
	

func _process(delta):
	#每帧后都加速
	create_timer.wait_time -= 0.2 * delta
	#限制wait_time在1到3之间
	create_timer.wait_time = clamp(create_timer.wait_time, 1, 3)
	#显示分数
	score_label.text = "Score: " + str(score)
	

	
	#每10分升一级
	var now_level = int(score / 10)
	if level <= 20 and level < now_level:
		level += 1
		#emit_signal("level_up", level)
		
func _create_slime():
	#print("生成史莱姆")
	var slime_node = slime_scens.instantiate()
	var set_y = randf_range(180, 258)
	#print("y轴是",set_y)
	slime_node.position  = Vector2(490, set_y)
	get_tree().current_scene.add_child(slime_node)
	
func show_gameover():
	get_node("/root/Bgm").stop()
	game_over_lable.visible = true
	
