extends Area2D

@export var speed = 400 # pixels p sec
var screen_size
var lives:int

func _ready():
	screen_size = get_viewport_rect().size
	lives = 3
	
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("Move_Right1"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Left1"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Down1"):
		velocity.y += 1
	if Input.is_action_pressed("Move_Up1"):
		velocity.y -= 1
	
	if Input.is_action_pressed("Move_Right2"):
		velocity.x += 1
	if Input.is_action_pressed("Move_Left2"):
		velocity.x -= 1
	if Input.is_action_pressed("Move_Down2"):
		velocity.y += 1
	if Input.is_action_pressed("Move_Up2"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "Walk_Right"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
signal hit



func _on_body_entered(body):
	if lives > 1:
		lives -= 1
	else:
		hide() # Player disappears after being hit.
		hit.emit()
		# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
