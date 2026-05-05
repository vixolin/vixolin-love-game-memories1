extends Control

# Computer UI - Interfaz del ordenador
# Muestra las cartas desbloqueadas con imágenes, texto y música

class_name ComputerUI

var current_memory_id: String = ""
var memory_system: MemorySystem

func _ready() -> void:
	initialize_ui()

func initialize_ui() -> void:
	# Crear elementos de UI del ordenador
	print("Computer UI initialized")

func display_memory(memory_id: String) -> void:
	# Mostrar una carta/recuerdo específica
	if not memory_system:
		return
	
	var memory = memory_system.get_memory(memory_id)
	if memory.is_empty():
		return
	
	current_memory_id = memory_id
	
	# Aquí irá la lógica para mostrar:
	# - Título
	# - Contenido de texto
	# - Imagen
	# - Botón para reproducir música
	
	print("Displaying memory: %s" % memory["title"])

func show_letter_list(unlocked_memories: Array[String]) -> void:
	# Mostrar lista de cartas desbloqueadas
	pass
