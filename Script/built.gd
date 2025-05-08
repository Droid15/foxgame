extends Area2D

@export var built_speed: float = 120.0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("slug_count")
	#生成的子弹三秒自动摧毁
	await  get_tree().create_timer(2).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += Vector2(built_speed, 0 ) * delta  
