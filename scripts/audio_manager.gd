extends Node

# Audio Manager - Gestor de audio y música
# Controla música, efectos de sonido y audio de cartas

class_name AudioManager

var current_music: AudioStreamPlayer
var sfx_player: AudioStreamPlayer

func _init() -> void:
	initialize_audio()

func initialize_audio() -> void:
	# Inicializar reproductores de audio
	print("Audio manager initialized")

func play_music(music_path: String, fade_in: bool = true) -> void:
	# Reproducir música de una carta
	if current_music:
		current_music.stop()
	
	if ResourceLoader.exists(music_path):
		current_music = AudioStreamPlayer.new()
		current_music.stream = load(music_path)
		current_music.bus = "Music"
		current_music.play()

func stop_music(fade_out: bool = true) -> void:
	# Detener música
	if current_music:
		current_music.stop()

func play_sfx(sfx_path: String) -> void:
	# Reproducir efecto de sonido
	if ResourceLoader.exists(sfx_path):
		sfx_player = AudioStreamPlayer.new()
		sfx_player.stream = load(sfx_path)
		sfx_player.bus = "SFX"
		sfx_player.play()

func play_unlock_sound() -> void:
	# Sonido especial para desbloqueos
	play_sfx("res://assets/audio/sfx/unlock.ogg")
