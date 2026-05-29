extends Node3D

const TileDataRes = preload("res://scripts/tile_data.gd")

@onready var face_front: MeshInstance3D = $FaceFront
@onready var face_back: MeshInstance3D = $FaceBack
@onready var face_left: MeshInstance3D = $FaceLeft
@onready var face_right: MeshInstance3D = $FaceRight

@export var tile_icons: Array[Texture2D]

var id: int = -1
var tile_data = null

func set_tile_data(data: Resource, icon_type: int) -> void:
	tile_data = data
	if tile_icons.is_empty():
		push_error("MahjongTile: tile_icons is empty — assign textures in the Inspector")
		return
	var texture: Texture2D = tile_icons[icon_type % tile_icons.size()]
	for face in [face_front, face_back, face_left, face_right]:
		var mat: StandardMaterial3D = face.get_active_material(0).duplicate()
		mat.albedo_texture = texture
		face.set_surface_override_material(0, mat)

func select() -> void:
	for face in [face_front, face_back, face_left, face_right]:
		face.get_active_material(0).albedo_color = Color(1.5, 1.5, 0.4)

func deselect() -> void:
	for face in [face_front, face_back, face_left, face_right]:
		face.get_active_material(0).albedo_color = Color(1, 1, 1)

func remove_tile() -> void:
	queue_free()

func counter_rotate_icons(delta_rad: float) -> void:
	for face in [face_front, face_back, face_left, face_right]:
		var face_normal: Vector3 = face.global_transform.basis.y.normalized()
		face.global_rotate(face_normal, delta_rad)
