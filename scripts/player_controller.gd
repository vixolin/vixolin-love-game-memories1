extends CharacterBody3D

# Player Controller - Control del jugador en primera persona
# Movimiento, mirada y interacción con objetos

class_name PlayerController

# Velocidades
const WALK_SPEED = 5.0
const MOUSE_SENSITIVITY = 0.002

# Referencias
@onready var camera = $Camera3D
@onready var interaction_raycast = $InteractionRaycast
@onready var interaction_label = $InteractionPrompt

# Estado
var current_interaction_item: Node3D = null
var can_interact: bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	interaction_label.visible = false

func _physics_process(delta: float) -> void:
	# Movimiento
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * WALK_SPEED
		velocity.z = direction.z * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)
		velocity.z = move_toward(velocity.z, 0, WALK_SPEED)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	# Mirada con ratón
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
	
	# Interacción
	if event.is_action_pressed("ui_accept"):
		if interaction_raycast.is_colliding():
			var collider = interaction_raycast.get_collider()
			if collider.is_in_group("collectibles"):
				collect_item(collider)

func collect_item(item: Node3D) -> void:
	# Recoger un objeto
	if item.has_method("collect"):
		item.collect()

func show_interaction_prompt(text: String) -> void:
	interaction_label.text = text
	interaction_label.visible = true

func hide_interaction_prompt() -> void:
	interaction_label.visible = false
