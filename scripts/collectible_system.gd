extends RefCounted

# Collectible System - Sistema de objetos coleccionables
# Gestiona objetos que se pueden encontrar y recopilar

class_name CollectibleSystem

signal item_collected(item_id: String, item_name: String)

var collectibles: Dictionary = {}
var collected_items: Array[String] = []

func _init() -> void:
	initialize_collectibles()

func initialize_collectibles() -> void:
	# Definir objetos coleccionables
	# Cada uno desbloqueará una memoria/carta específica
	
	collectibles = {
		"plushie_cat": {
			"name": "Peluche de Gato",
			"description": "Un pequeño gato de peluche suave",
			"memory_unlock": "letter_first_meeting",
			"position": Vector2(400, 300),
			"sprite": "res://assets/graphics/collectibles/plushie_cat.png"
		},
		"photo_beach": {
			"name": "Foto en la Playa",
			"description": "Una fotografía especial de un momento compartido",
			"memory_unlock": "letter_beach_day",
			"position": Vector2(800, 250),
			"sprite": "res://assets/graphics/collectibles/photo_beach.png"
		},
		"love_letter": {
			"name": "Carta de Amor",
			"description": "Una carta escrita con el corazón",
			"memory_unlock": "letter_confession",
			"position": Vector2(500, 600),
			"sprite": "res://assets/graphics/collectibles/love_letter.png"
		},
		"rose": {
			"name": "Rosa Roja",
			"description": "Una rosa eterna, símbolo del amor",
			"memory_unlock": "letter_forever",
			"position": Vector2(1200, 400),
			"sprite": "res://assets/graphics/collectibles/rose.png"
		},
		"music_box": {
			"name": "Caja de Música",
			"description": "Una caja que toca una melodía especial",
			"memory_unlock": "letter_our_song",
			"position": Vector2(600, 500),
			"sprite": "res://assets/graphics/collectibles/music_box.png"
		}
	}

func collect_item(item_id: String) -> bool:
	# Recoger un objeto
	if item_id in collectibles and item_id not in collected_items:
		collected_items.append(item_id)
		var item = collectibles[item_id]
		item_collected.emit(item_id, item["name"])
		return true
	return false

func is_collected(item_id: String) -> bool:
	return item_id in collected_items

func get_collectible(item_id: String) -> Dictionary:
	return collectibles.get(item_id, {})

func get_all_collectibles() -> Dictionary:
	return collectibles

func get_collected_count() -> int:
	return collected_items.size()

func get_total_count() -> int:
	return collectibles.size()
