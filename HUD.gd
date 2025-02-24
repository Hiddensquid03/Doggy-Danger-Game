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
	
	if score == get_parent().tennis_balls[get_parent().difficulty]:
		print("You win")
		show_game_over()
		show_message("You win")
	
func update_Lifes(lives):
	$lives.text = str(lives)
	
func _on_start_button_pressed():
	$Message.hide()
	$StartButton.hide()
	$"Hard button".hide()
	start_game.emit()
	get_parent().difficulty = 0

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_game():
	get_parent().start_timers()
	print("Pressed start game")
	var timeremainder = $Timeremainder
	var playingTime = $PlayingTime
	
func show_game_over():
	get_parent().is_game_over = true
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	get_tree().quit()
	

	$Message.text = "Doggy Danger!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$"Hard button".show()
	
#func clear_scene():
	
	#var tennis_balls = get_node("TennisBall") # GET ARRAY OF ALL OCCURENCES OF TennisBall
	#if tennis_balls != null:
	#	for tball in tennis_balls:
	#		tball.remove_child()
	#		tball.queue_free()
			
	#get pools
	#get lawnmowers
#func _updatetimer(delta):
#	update_label_Text()

#func update_label_Text():
#	$ScoreLabel.text = str(ceil($Timeremainder.time_left))
	

var time_left = 30
func _on_playing_time_timeout():
	if time_left >= 0:
		$Timeremainder.text = str(time_left)
		time_left -= 1
	else:
		print("Game Over")
		show_game_over()
		show_message("Timed out")
		
		
	pass # Replace with function body.


func _on_hard_button_pressed():
	$Message.hide()
	$StartButton.hide()
	$"Hard button".hide()
	get_parent().difficulty = 1
	start_game.emit()

