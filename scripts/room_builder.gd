extends Node3D

# Room Builder - Constructor de la habitación
# Crea toda la estructura de la habitación proceduralmente

class_name RoomBuilder

func _init() -> void:
	build_room()

func build_room() -> void:
	# ESTRUCTURAS PRINCIPALES
	build_walls()
	build_floor()
	build_ceiling()
	
	# MUEBLES
	build_bed()
	build_desk()
	build_wardrobe()
	build_bookshelf()
	
	# OBJETOS DISPERSOS
	disperse_clothes()
	disperse_plushies()

func build_walls() -> void:
	# Paredes (blanco/gris estilo tinta china)
	var wall_material = StandardMaterial3D.new()
	wall_material.albedo_color = Color(0.9, 0.9, 0.9, 1.0)  # Gris claro
	
	# Pared frontal
	var front_wall = CSGBox3D.new()
	front_wall.size = Vector3(10, 3, 0.1)
	front_wall.position = Vector3(0, 1.5, -5)
	front_wall.material = wall_material
	
	# Paredes laterales
	var left_wall = CSGBox3D.new()
	left_wall.size = Vector3(0.1, 3, 10)
	left_wall.position = Vector3(-5, 1.5, 0)
	left_wall.material = wall_material
	
	var right_wall = CSGBox3D.new()
	right_wall.size = Vector3(0.1, 3, 10)
	right_wall.position = Vector3(5, 1.5, 0)
	right_wall.material = wall_material

func build_floor() -> void:
	# Piso
	var floor_material = StandardMaterial3D.new()
	floor_material.albedo_color = Color(0.7, 0.7, 0.7, 1.0)  # Gris medio
	
	var floor = CSGBox3D.new()
	floor.size = Vector3(10, 0.1, 10)
	floor.position = Vector3(0, 0, 0)
	floor.material = floor_material

func build_ceiling() -> void:
	# Techo
	var ceiling_material = StandardMaterial3D.new()
	ceiling_material.albedo_color = Color(0.95, 0.95, 0.95, 1.0)  # Blanco
	
	var ceiling = CSGBox3D.new()
	ceiling.size = Vector3(10, 0.1, 10)
	ceiling.position = Vector3(0, 3, 0)
	ceiling.material = ceiling_material

func build_bed() -> void:
	# Cama
	var bed_material = StandardMaterial3D.new()
	bed_material.albedo_color = Color(0.6, 0.6, 0.6, 1.0)
	
	var bed_frame = CSGBox3D.new()
	bed_frame.size = Vector3(2, 0.1, 3)
	bed_frame.position = Vector3(-3, 0.5, 3)
	bed_frame.material = bed_material

func build_desk() -> void:
	# Escritorio
	var desk_material = StandardMaterial3D.new()
	desk_material.albedo_color = Color(0.5, 0.4, 0.3, 1.0)  # Marrón
	
	var desk_top = CSGBox3D.new()
	desk_top.size = Vector3(2.5, 0.1, 1.5)
	desk_top.position = Vector3(2, 0.8, -1)
	desk_top.material = desk_material

func build_wardrobe() -> void:
	# Armario/Ropero
	var wardrobe_material = StandardMaterial3D.new()
	wardrobe_material.albedo_color = Color(0.55, 0.45, 0.35, 1.0)
	
	var wardrobe = CSGBox3D.new()
	wardrobe.size = Vector3(1.5, 2, 0.7)
	wardrobe.position = Vector3(4, 1, 2)
	wardrobe.material = wardrobe_material

func build_bookshelf() -> void:
	# Librería
	var shelf_material = StandardMaterial3D.new()
	shelf_material.albedo_color = Color(0.5, 0.4, 0.3, 1.0)
	
	var bookshelf = CSGBox3D.new()
	bookshelf.size = Vector3(1.5, 1.8, 0.5)
	bookshelf.position = Vector3(-4, 0.9, 2)
	bookshelf.material = shelf_material

func disperse_clothes() -> void:
	# Ropa dispersa por la habitación
	var clothes_positions = [
		Vector3(-2, 0.1, 2),
		Vector3(1, 0.1, -2),
		Vector3(-3.5, 0.1, 0),
		Vector3(3, 0.1, 1)
	]
	
	for pos in clothes_positions:
		var cloth = CSGBox3D.new()
		cloth.size = Vector3(0.3, 0.05, 0.4)
		cloth.position = pos
		var material = StandardMaterial3D.new()
		material.albedo_color = Color(0.6, 0.5, 0.4, 1.0)
		cloth.material = material

func disperse_plushies() -> void:
	# Peluches dispersos
	var plushie_positions = [
		Vector3(-2.5, 0.5, 3.5),  # En la cama
		Vector3(-3.8, 0.9, 2.2),  # En la librería
		Vector3(2, 1.2, -1),       # En el escritorio
	]
	
	for pos in plushie_positions:
		var plushie = CSGSphere3D.new()
		plushie.radius = 0.3
		plushie.position = pos
		var material = StandardMaterial3D.new()
		material.albedo_color = Color(0.9, 0.7, 0.7, 1.0)  # Rosa/piel
		plushie.material = material
