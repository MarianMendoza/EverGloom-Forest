extends Area2D

@export var dialogue_resource : DialogueResource
@export var dialouge_start: String = "start"

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialouge_start)
