extends Node2D

# Game Manager - Gestor principal del juego
# Controla el flujo principal, sistemas y estados

class_name GameManager

# Referencias a sistemas principales
var collectible_system: CollectibleSystem
var memory_system: MemorySystem
var visual_effects: VisualEffects
var audio_manager: AudioManager
var computer_ui: ComputerUI

# Estado del juego
var game_state: Dictionary = {}
var collected_items: Array[String] = []
var unlocked_memories: Array[String] = []

func _ready() -> void:
	# Inicializar sistemas
	initialize_systems()
	load_game_state()
	setup_initial_scene()

func initialize_systems() -> void:
	# Crear instancias de los sistemas
	collectible_system = CollectibleSystem.new()
	memory_system = MemorySystem.new()
	visual_effects = VisualEffects.new()
	audio_manager = AudioManager.new()
	
	# Conectar señales
	collectible_system.item_collected.connect(_on_item_collected)


func load_game_state() -> void:
	# Cargar estado guardado del juego
	var save_file = "user://game_state.save"
	if ResourceLoader.exists(save_file):
		game_state = ResourceLoader.load(save_file)
		collected_items = game_state.get("collected_items", [])
		unlocked_memories = game_state.get("unlocked_memories", [])
	else:
		# Estado inicial
		game_state = {
			"collected_items": [],
			"unlocked_memories": [],
			"playtime": 0.0
		}


func setup_initial_scene() -> void:
	# Configurar la escena inicial
	print("Game initialized. Ready to explore memories...")
	# Aquí irán las inicializaciones específicas de la escena


func _on_item_collected(item_id: String, item_name: String) -> void:
	# Cuando se recoge un objeto
	if item_id not in collected_items:
		collected_items.append(item_id)
		
		# Desbloquear memoria asociada
		var memory_id = memory_system.get_memory_for_item(item_id)
		if memory_id and memory_id not in unlocked_memories:
			unlocked_memories.append(memory_id)
			audio_manager.play_unlock_sound()
			
		print("Item collected: %s. Memory unlocked: %s" % [item_name, memory_id])
		
		# Guardar progreso
		save_game_state()


func save_game_state() -> void:
	# Guardar estado del juego
	game_state["collected_items"] = collected_items
	game_state["unlocked_memories"] = unlocked_memories
	game_state["playtime"] += get_process_delta_time()
	
	var save_file = "user://game_state.save"
	ResourceSaver.save(game_state, save_file)


func _process(delta: float) -> void:
	# Actualizar tiempo de juego
	if game_state:
		game_state["playtime"] = game_state.get("playtime", 0.0) + delta
