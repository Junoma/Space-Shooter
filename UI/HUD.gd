extends Control


var VP = Vector2.ZERO
var Indicator = load("res://UI/indicator.tscn")
var health = 10
var y_positions = [100,150,200,500,550]
var initial_position = Vector2.ZERO
var dicrection = Vector2(1.5,0)
var wobble = 30.0
var lives_pos = Vector2(20, Global.VP.y - 20)
var lives_index = 30


func _ready():
	VP = get_viewport().size
	var _signal = get_tree().get_root().size_changed.connect(_resize)
	initial_position.x = -100
	initial_position.y = y_positions[randi() % y_positions.size()]
	position = initial_position
	update_score()
	update_time()
	update_lives()
	
func _physics_process(_delta):
	position += dicrection
	position.y = initial_position.Y + sin(position.x/20)*wobble
	if position.x > 1200:
		queue_free() 

func update_score():
	$Score.text = "Score: "  + str(Global.score)
	
func update_time():
		$Time.text = "Time: " + str(Global.time)
		
func update_lives():
	lives_pos = Vector2(20, Global.VP.y - 20)
	for child in $Indicator_Container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var indicator = Indicator.instantiate()
		indicator.position = lives_pos + Vector2(lives_index*i, 0)
		$Indicator_Container.add_child(indicator)
	
func _resize(): 
	VP = get_viewport().size

func _on_timer_timeout():
	Global.update_time(-1)
	update_time()
	if Global.time <= 0:
		get_tree().change_scene_to_file("res://UI/end_game.tscn")
