@tool
extends Area2D


## shape of the zone!
@export var shape: Shape2D:
	set(new_shape):
		if shape == new_shape:
			return
		if shape != null and shape.changed.is_connected(queue_redraw):
			shape.changed.disconnect(queue_redraw)
		shape = new_shape
		if shape != null and not shape.changed.is_connected(queue_redraw):
			shape.changed.connect(queue_redraw)

		queue_redraw()

func _ready():
	$CollisionShape2D.shape = shape

func _draw():
	if not Engine.is_editor_hint() or shape == null:
		return
	shape.draw(get_canvas_item(), Color(1.0, 0.591, 0.698, 0.471))

func _get_configuration_warnings() -> PackedStringArray:
	return PackedStringArray()

func _on_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("uid://gml50n8ngapb")
