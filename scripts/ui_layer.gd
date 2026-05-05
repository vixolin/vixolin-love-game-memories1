extends CanvasLayer

# UI Layer - Capa de interfaz de usuario
# Maneja la UI del ordenador y prompts de interacción

class_name UILayer

@onready var computer_screen = $ComputerScreen
@onready var interaction_prompt = $InteractionPrompt

func _ready() -> void:
	if computer_screen:
		computer_screen.visible = false
	if interaction_prompt:
		interaction_prompt.visible = false

func show_computer_ui(memories: Array[String]) -> void:
	# Mostrar UI del ordenador
	if computer_screen:
		computer_screen.visible = true
		# Aquí irá la lógica para mostrar las cartas

func hide_computer_ui() -> void:
	# Ocultar UI del ordenador
	if computer_screen:
		computer_screen.visible = false

func show_interaction_prompt(text: String) -> void:
	if interaction_prompt:
		interaction_prompt.text = text
		interaction_prompt.visible = true

func hide_interaction_prompt() -> void:
	if interaction_prompt:
		interaction_prompt.visible = false
