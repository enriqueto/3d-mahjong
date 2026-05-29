extends Node3D

@onready var camera: Camera3D = $Camera3D
@onready var board_container: Node3D = $BoardContainer
@onready var board_manager: Node = $BoardManager

func _ready() -> void:
	board_container.tile_selected.connect(board_manager.on_tile_selected)
	board_container.board_ready.connect(board_manager.on_board_ready)
	board_container.layer_rotated.connect(func(axis, value, angle):
		board_manager.on_layer_rotated(axis, value, angle, board_container.spacing)
	)
	$GUI/Control/RightArrowBtn.pressed.connect(_on_rotate_right)
	$GUI/Control/LeftArrowBtn.pressed.connect(_on_rotate_left)
	$GUI/Control/ShuffleBtn.pressed.connect(_on_shuffle)

func _on_rotate_right() -> void:
	board_container.rotate_board(true)

func _on_rotate_left() -> void:
	board_container.rotate_board(false)

func _on_shuffle() -> void:
	board_container.shuffle()
