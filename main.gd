extends Node
@export var mob_scene: PackedScene
@export var Tennis_ballscene: PackedScene
@export var Pool_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass
	

func increment_score():
	score += 1
	print(score)
	$Hud.update_score(score)

func decrease_lives():
	$Hud.update_Lifes($player.get_lives())

func game_over():
	#$"Score timer".stop()
	$Mobtimer.stop()
	$Hud.show_game_over()

func new_game():
	score = 0
	if $player != null:
		$player.start($"Start position".position)
		$player.z_index = 10
	else:
		print("Failed to find player in scene")
	#$"Start timer".start()
	
	for i in 20:
		var Tennisball = Tennis_ballscene.instantiate()
		Tennisball.position = Vector2(randf_range(35,470),randf_range(33, 720))
		add_child(Tennisball)
		Tennisball.z_index = 10
		
	# get rand pos
	var poolNumber = randi_range(1,8);
	var poolPosition = get_node("PoolSpawner" + str(poolNumber)).global_position;
	
	# set to pos
	var pool = Pool_scene.instantiate()
	pool.position = poolPosition
	add_child(pool)
	pool.z_index = 1
	
	$Hud.update_score(score)
	#$Hud.show_message("Get Ready")
	
func _on_mobtimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $Mobpath/Mobspawnlocation
	mob_spawn_location.progress_ratio = randf()
	mob.z_index= 10

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)



func _on_score_timer_timeout():
	pass

#func _on_start_timer_timeout():
func start_timers():
	new_game()
	$Hud.update_score(score)
	$Mobtimer.start()
	$"Score timer".start()

func player():
	pass
	
	
