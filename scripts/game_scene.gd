extends Node3D

# Game Scene - Lógica principal de la escena del juego
# Gestiona cinemática de inicio, sistemas del juego, etc.

class_name GameScene

# Referencias
@onready var player = $Player
@onready var camera = player.get_node("Camera3D")
@onready var ui_layer = $UILayer

# Sistemas
var game_manager: GameManager
var collectible_system: CollectibleSystem
var memory_system: MemorySystem
var visual_effects: VisualEffects
var audio_manager: AudioManager

# Estado
var startup_complete: bool = false
var in_cutscene: bool = false

func _ready() -> void:
	# Inicializar sistemas
	initialize_systems()
	
	# Construcción de la habitación
	build_room()
	
	# Desactivar controles del jugador durante cinemática
	player.set_physics_process(false)
	
	# Iniciar cinemática de despertar

await startup_cinematic()
	
	# Activar controles
	player.set_physics_process(true)

func initialize_systems() -> void:
	# Crear instancias de los sistemas
	game_manager = GameManager.new()
	collectible_system = CollectibleSystem.new()
	memory_system = MemorySystem.new()
	visual_effects = VisualEffects.new()
	audio_manager = AudioManager.new()
	
	# Cargar estado del juego
	game_manager.collectible_system = collectible_system
	game_manager.memory_system = memory_system
	# Conectar señales
	collectible_system.item_collected.connect(_on_item_collected)

memory_system.memory_unlocked.connect(_on_memory_unlocked)

func build_room() -> void:
	# Construcción de la habitación
	# TODO: Implementar construcción detallada de la habitación
	print("Room built successfully")

func startup_cinematic() -> void:
	# CINEMÁTICA DE DESPERTAR
	in_cutscene = true
	
	# Paso 1: Parpadeo inicial (3 veces)
	for i in range(3):
		# Oscurecer
		var fade_overlay = ColorRect.new()
		fade_overlay.color = Color.BLACK
		fade_overlay.anchor_right = 1.0
		fade_overlay.anchor_bottom = 1.0
		add_child(fade_overlay)
		
		var tween = create_tween()
		tween.tween_property(fade_overlay, "modulate:a", 1.0, 0.3)
		tween.tween_callback(func(): pass)
		tween.tween_property(fade_overlay, "modulate:a", 0.0, 0.5)
		
		await tween.finished
		fade_overlay.queue_free()
		await get_tree().process_frame
	
	# Paso 2: Pausa con visión borrosa (2 segundos)
	var blur_overlay = ColorRect.new()
	blur_overlay.color = Color(0.5, 0.5, 0.5, 0.3)
	blur_overlay.anchor_right = 1.0
	blur_overlay.anchor_bottom = 1.0
	add_child(blur_overlay)
	
	await get_tree().create_timer(2.0).timeout
	
	# Paso 3: Desvanecimiento de visión borrosa
	var tween = create_tween()
	tween.tween_property(blur_overlay, "modulate:a", 0.0, 1.0)
	await tween.finished
	blur_overlay.queue_free()
	
	# Paso 4: Mostrar texto de diálogo
	show_dialog_text("Vaya... qué desastre. Debo ordenar este lugar.")
	await get_tree().create_timer(2.5).timeout
	
	# Paso 5: Desbloquear primera carta automáticamente
	unlock_first_memory()
	
	# Mostrar notificación
	show_notification("Primera carta desbloqueada. Revisa el ordenador (Tab)")
	await get_tree().create_timer(2.0).timeout
	
	in_cutscene = false
	startup_complete = true

func show_dialog_text(text: String) -> void:
	# Mostrar texto de diálogo en la pantalla
	var dialog_label = Label.new()
	dialog_label.text = text
	dialog_label.add_theme_font_size_override("font_size", 32)
	dialog_label.anchor_left = 0.5
	dialog_label.anchor_top = 0.5
	dialog_label.offset_left = -200
	dialog_label.offset_top = -50
	dialog_label.custom_minimum_size = Vector2(400, 100)
	dialog_label.alignment = HORIZONTAL_ALIGNMENT_CENTER
	dialog_label.add_theme_color_override("font_color", Color.WHITE)
	add_child(dialog_label)
	
	var tween = create_tween()
	tween.tween_property(dialog_label, "modulate:a", 1.0, 0.5)
	tween.tween_callback(func(): pass)
	tween.tween_property(dialog_label, "modulate:a", 0.0, 1.5)
	
	await tween.finished
	dialog_label.queue_free()

func show_notification(text: String) -> void:
	# Mostrar notificación en la pantalla
	var notif_label = Label.new()
	notif_label.text = text
	notif_label.add_theme_font_size_override("font_size", 24)
	notif_label.anchor_top = 0.0
	notif_label.anchor_left = 0.5
	notif_label.offset_left = -250
	notif_label.offset_top = 20
	notif_label.custom_minimum_size = Vector2(500, 50)
	notif_label.alignment = HORIZONTAL_ALIGNMENT_CENTER
	notif_label.add_theme_color_override("font_color", Color.YELLOW)
	add_child(notif_label)
	
	var tween = create_tween()
	tween.tween_property(notif_label, "modulate:a", 1.0, 0.3)
	tween.tween_callback(func(): pass)
	tween.tween_property(notif_label, "modulate:a", 0.0, 1.0)
	
	await tween.finished
	notif_label.queue_free()

func unlock_first_memory() -> void:
	# Desbloquear la primera carta automáticamente
	var first_memory = "letter_first_meeting"
	memory_system.unlock_memory(first_memory)
	game_manager.unlocked_memories.append(first_memory)

func _on_item_collected(item_id: String, item_name: String) -> void:
	# Cuando se recoge un objeto
	show_notification("Recogiste: %s" % item_name)

func _on_memory_unlocked(memory_id: String) -> void:
	# Cuando se desbloquea una memoria
	show_notification("¡Nueva carta desbloqueada!")
