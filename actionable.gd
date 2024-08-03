extends Area2D

const Balloon = preload("res://dialouge/balloon.tscn")
@export var dialogue_resource : DialogueResource
@export var dialouge_start: String = "start"


func action () -> void:
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	balloon.start(dialogue_resource, dialouge_start)
