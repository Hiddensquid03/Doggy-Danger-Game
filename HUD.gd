extends CanvasLayer
# Notifies `Main` node that the button has been pressed
signal start_game

func _ready():
	$Message.text = "Doggy Danger!"
	$Message.show()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_Lifes(lives):
	$lives.text = str(lives)
	
func _on_start_button_pressed():
	$Message.hide()
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_game():
	clear_scene()
	get_parent().start_timers()
	print("Pressed start game")
	pass 
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	

	$Message.text = "Doggy Danger!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func clear_scene():
	pass
	var tennis_balls = get_node("TennisBall") # GET ARRAY OF ALL OCCURENCES OF TennisBall
	if tennis_balls != null:
		for tball in tennis_balls:
			tball.queue_free()
	#get pools
	#get lawnmowers
	
