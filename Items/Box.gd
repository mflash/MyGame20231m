extends Area2D


func _ready() -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(2.5, 2.5), 0.2)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
		
func _on_Box_body_entered(body: Node) -> void:
	print("Ouch!")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("Saiu!")
	queue_free()
