extends Node3D

# Collectible Item - Lógica de objetos coleccionables
# Maneja la interacción y recogida de objetos

class_name CollectibleItem

@export var item_id: String = ""
@export var item_name: String = ""
@export var animation_duration: float = 0.5

# Referencias
var game_scene: GameScene
var original_position: Vector3
var target_position: Vector3
var is_collected: bool = false

func _ready() -> void:
	add_to_group("collectibles")
	original_position = position
	game_scene = get_tree().current_scene

func collect() -> void:
	# Recoger el objeto
	if is_collected:
		return
	
	is_collected = true
	
	# Emitir señal al sistema
	if game_scene and game_scene.collectible_system:
		game_scene.collectible_system.collect_item(item_id)
		
		# Obtener posición destino (escritorio)
		target_position = game_scene.get_node("Desk").position + Vector3(0, 0.5, 0)
		
		# Animar movimiento al escritorio
		var tween = create_tween()
		tween.tween_property(self, "position", target_position, animation_duration)
		
		await tween.finished
