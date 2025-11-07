extends Node2D




func _on_story_pressed():
	get_tree().change_scene_to_file("res://Story.tscn")


func _on_inventory_pressed():
	get_tree().change_scene_to_file("res://Inventory.tscn")


func _on_shop_pressed():
	get_tree().change_scene_to_file("res://Shop.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Options.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Credits.tscn")


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")
