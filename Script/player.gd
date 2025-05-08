extends CharacterBody2D

@export var move_speed: float =  150.0
@export var animator: AnimatedSprite2D
@export var has_game_over: bool = false

@export var bulit_scens: PackedScene
var shooting = false

func _process(delta):
	if velocity == Vector2.ZERO or has_game_over:
		$runing.stop()	
	elif not $runing.playing:
		$runing.play()
		
func _physics_process(delta):
#func _process(delta):
	if not has_game_over:
		velocity = Input.get_vector("左","右","上","下") * move_speed
	
		#速度为0的时候播放idel动画
		if velocity == Vector2.ZERO:
			animator.play("idel")
		#速度不为0的时候播放跑步动画
		else:
			animator.play("run")
			
		#开火动作
		if Input.is_action_just_pressed("开火"):
			#统计子弹数量
			var t: int = get_tree().get_node_count_in_group("slug_count")
			if t < 3:
				_on_fire()
			
		move_and_slide()

func start_game():
	get_tree().reload_current_scene()
		
func game_over():
	if not has_game_over:
		has_game_over = true
		animator.play("gameover")
		$gameover.play()
		#显示游戏结束画面
		get_tree().current_scene.show_gameover()
		
		#等待3秒重载场景
		await get_tree().create_timer(3).timeout
		#$"../game_wait".visible = true
		$"../game_start_btn".visible = true
		#get_tree().reload_current_scene()
#开枪
func _on_fire():
	#玩家速度不等于0
	if velocity != Vector2.ZERO or has_game_over:
		return
	
	if shooting:
		return
		
	$onfire.play()
	
	var bulit_node = bulit_scens.instantiate()
	#自带加上6,6偏移让它从枪管发出
	bulit_node.position = position + Vector2(16 , 7)
	get_tree().current_scene.add_child(bulit_node)
	
	#限制0.5秒才能开一次抢
	shooting = true
	await  get_tree().create_timer(0.5).timeout
	shooting = false
	
func _on_button_button_down() -> void:
	start_game()
