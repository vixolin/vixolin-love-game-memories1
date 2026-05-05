extends RefCounted

# Memory System - Sistema de recuerdos/cartas
# Gestiona las cartas especiales que se desbloquean

class_name MemorySystem

signal memory_unlocked(memory_id: String)

var memories: Dictionary = {}
var unlocked_memories: Array[String] = []

func _init() -> void:
	initialize_memories()

func initialize_memories() -> void:
	# Definir recuerdos/cartas
	# Cada uno tiene imágenes, música y mensajes dulces
	
	memories = {
		"letter_first_meeting": {
			"title": "Nuestro Primer Encuentro",
			"content": "Cuando te vi por primera vez, mi corazón supo que eras especial...",
			"image": "res://assets/memories/letters/first_meeting.png",
			"music": "res://assets/audio/music/letter_1.ogg",
			"unlock_item": "plushie_cat"
		},
		"letter_beach_day": {
			"title": "Día en la Playa",
			"content": "Esos momentos contigo bajo el sol son mis favoritos. Tu sonrisa lo ilumina todo.",
			"image": "res://assets/memories/letters/beach_day.png",
			"music": "res://assets/audio/music/letter_2.ogg",
			"unlock_item": "photo_beach"
		},
		"letter_confession": {
			"title": "Mi Confesión",
			"content": "Te amo más cada día. Eres mi razón de sonreír, mi paz y mi alegría.",
			"image": "res://assets/memories/letters/confession.png",
			"music": "res://assets/audio/music/letter_3.ogg",
			"unlock_item": "love_letter"
		},
		"letter_forever": {
			"title": "Para Siempre",
			"content": "Quiero vivir contigo todos mis días, crear recuerdos eternos y amarte sin fin.",
			"image": "res://assets/memories/letters/forever.png",
			"music": "res://assets/audio/music/letter_4.ogg",
			"unlock_item": "rose"
		},
		"letter_our_song": {
			"title": "Nuestra Canción",
			"content": "Cada nota de esta melodía te representa. Hermosa, perfecta y para siempre mía.",
			"image": "res://assets/memories/letters/our_song.png",
			"music": "res://assets/audio/music/letter_5.ogg",
			"unlock_item": "music_box"
		}
	}

func unlock_memory(memory_id: String) -> void:
	if memory_id in memories and memory_id not in unlocked_memories:
		unlocked_memories.append(memory_id)
		memory_unlocked.emit(memory_id)

func is_unlocked(memory_id: String) -> bool:
	return memory_id in unlocked_memories

func get_memory(memory_id: String) -> Dictionary:
	return memories.get(memory_id, {})

func get_all_unlocked_memories() -> Array[String]:
	return unlocked_memories

func get_memory_for_item(item_id: String) -> String:
	# Obtener el ID de memoria que desbloquea un objeto
	for memory_id in memories:
		if memories[memory_id].get("unlock_item") == item_id:
			return memory_id
	return ""

func get_unlocked_count() -> int:
	return unlocked_memories.size()

func get_total_count() -> int:
	return memories.size()
