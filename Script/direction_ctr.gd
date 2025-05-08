extends TouchScreenButton

const DRAG_RADIUS := 26.0

var finger_index := 0
var drag_offset: Vector2

@onready var rest_pos := global_position
var abs_position

func  _ready() -> void:
	abs_position = global_position
	add_to_group("drag_area")

func _input(event: InputEvent) -> void:
	
	#手指离开屏幕时释放方向键按压模拟
	if event is InputEventMouseButton:
		Input.action_release("上")
		Input.action_release("下")
		Input.action_release("左")
		Input.action_release("右")
		global_position = abs_position
		return 
		
	#从按下摇杆的起点计算拖动距离
	var st := event as InputEventScreenTouch
	if st and st.pressed and st.position.x < 300:
		var global_pos := st.position * get_canvas_transform()
		var local_pos := global_pos * get_global_transform()
		drag_offset = global_pos - global_position
	
	 #屏幕拖拽事件
	var sd: = event as InputEventScreenDrag
	if sd and sd.position.x < 300:
		#拖动
		var wish_pos := sd.position * get_canvas_transform() - drag_offset
		var movement := (wish_pos - rest_pos).limit_length(DRAG_RADIUS)
		global_position = rest_pos + movement
		
		movement /= DRAG_RADIUS
		if movement.x >0 :
			Input.action_press("右", movement.x)
		elif movement.x <0:
			Input.action_press("左", -movement.x)
			
		if movement.y >0 :
			Input.action_press("下", movement.y)
		elif movement.y <0:
			Input.action_press("上", -movement.y)
