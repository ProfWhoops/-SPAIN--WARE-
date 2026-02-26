extends CharacterBody2D

@onready var marker_2d = %Marker2D
@onready var animations = $AnimatedSprite2D
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var coyote_timer = $CoyoteTimer

@export var speed := 450
@export var acceleration := 40
@export var jump_speed := -speed * 2
@export var gravity := speed * 5
@export var down_gravity_factor := 2.0

enum State{IDLE, RUN, JUMP, DOWN}
var current_state: State = State.IDLE

func _ready() -> void:
	position = marker_2d.position
	velocity.y = 0



func _physics_process(delta) -> void:
	handle_input()
	update_movement(delta)
	update_states()
	update_animation()
	move_and_slide()
	


func handle_input():
	if Input.is_action_just_released("Up") && current_state == State.JUMP:
		velocity.y = jump_speed / 3.0
		
	if Input.is_action_just_pressed("Up"):
		jump_buffer_timer.start()
		
	var direction = Input.get_axis("Left", "Right")
	
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration)
		
func update_movement(delta: float) -> void:
	if (is_on_floor() || coyote_timer.time_left > 0) && jump_buffer_timer.time_left > 0:
		velocity.y = jump_speed
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
		
	if current_state == State.JUMP:
		velocity.y  += gravity * delta
	else:
		velocity.y += gravity * down_gravity_factor * delta

func update_states() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.RUN
		
		State.RUN:
			if velocity.x == 0:
				current_state = State.IDLE
			if not is_on_floor() && velocity.y > 0:
				current_state = State.DOWN
				coyote_timer.start()
				
		State.JUMP when velocity.y > 0:
			current_state = State.DOWN
		
		State.DOWN when is_on_floor():
			if velocity.x == 0:
				current_state = State.IDLE
			else:
				current_state = State.RUN
			
	
	
func update_animation() -> void:
	if velocity.x != 0:
		animations.flip_h = velocity.x < 0
		
	
	match current_state:
		State.IDLE: animations.play("idle")
		State.RUN: animations.play("run")
		State.JUMP: animations.play("jump_up")
		State.DOWN: animations.play("jump_down")


func hit_question_block():
	print("hit question block")
	

func _on_area_2d_body_entered(body) -> void:
	if body == self:
		position = marker_2d.position
		velocity.y = 0
