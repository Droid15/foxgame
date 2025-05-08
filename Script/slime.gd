extends Area2D

@export var slime_speed:float = -50.0
var is_dead: bool = false
var level: int
func _ready():
	
	get_tree().current_scene.connect("level_up", _on_level_up)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#销毁超出屏幕的史莱姆
	if position.x < -210:
		#print("销毁史莱姆")
		queue_free()
		
	if not is_dead:
		# 史莱姆场景会被定时销毁，当前定义的变量也会重置，因此level变量应该从外部获取参与计算
		level = get_tree().current_scene.level
		#print("level:", level)
		position += Vector2(slime_speed - level*5, 0) * delta

#史莱姆和玩家的碰撞检测
func _on_body_entered(body):
	if body is CharacterBody2D and not is_dead:
		#print("hit slime ")
		body.game_over()

func _on_area_entered(area):
	
	#子弹碰到了史莱姆
	if area.is_in_group("bulit"):
		is_dead = true
		$AnimatedSprite2D.play("killd")
		$slimedead.play()
		#销毁子弹
		area.queue_free()
		
		#0.6秒后销毁
		await  get_tree().create_timer(0.2).timeout
		queue_free()
		
		get_tree().current_scene.score += 1
		
#监听升级信号
func _on_level_up(level):
	print("level升级:",level)
