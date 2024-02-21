@tool
class_name TerraNode
extends PanelContainer

@export var title: String = "Node":
	set(val):
		title = val
		$VBoxContainer/Titlebar/MarginContainer/CenterContainer/Title.text = val
@export var catagory: TerraCatagories.TerraCatagory = TerraCatagories.TerraCatagory.MISCELLANEOUS

var scene: PackedScene = preload("res://Nodes/TerraNode.tscn")

func _enter_tree():
	var node = scene.instantiate()
	
	for child in node.get_children():
		var new_child = child.duplicate() # would like to reparent, but not ancestor
		add_child(new_child)
	
	title = title # Make sure the title label has the correct value

func _exit_tree():
	for child in get_children():
		child.queue_free()
