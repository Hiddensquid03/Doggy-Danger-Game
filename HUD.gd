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
	
	#updates score to label
func update_score(score):
	$ScoreLabel.text = str(score)
	
	#added score wincon
	if score == get_parent().tennis_balls[get_parent().difficulty]:
		show_game_over()
		show_message("You win")
	
	#updates lives to label
func update_Lifes(lives):
	$lives.text = str(lives)
	
	#hidesbuttons(Easy)
func _on_start_button_pressed():
	$Message.hide()
	$StartButton.hide()
	$"Hard button".hide()
	start_game.emit()
	get_parent().difficulty = 0

func _on_message_timer_timeout():
	$Message.hide()

#start game condition

func _on_start_game():
	get_parent().start_timers()
	var timeremainder = $Timeremainder
	var playingTime = $PlayingTime
	
	#gameover condition
func show_game_over():
	get_parent().is_game_over = true
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout
	get_tree().quit()
	
#menu
	$Message.text = "Doggy Danger!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$"Hard button".show()
	
	#timeout win con + timer hud 
var time_left = 30
func _on_playing_time_timeout():
	if time_left >= 0:
		$Timeremainder.text = str(time_left)
		time_left -= 1
	else:
		show_game_over()
		show_message("Timed out")
		await get_tree().create_timer(1.0).timeout
		get_tree().quit()
		
	pass # Replace with function body.

#hidesbuttons hard 
func _on_hard_button_pressed():
	$Message.hide()
	$StartButton.hide()
	$"Hard button".hide()
	get_parent().difficulty = 1
	start_game.emit()

