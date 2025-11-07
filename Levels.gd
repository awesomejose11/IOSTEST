extends Node

# Change this to your actual world selection scene path
const WORLD_SCENE := "res://Scenes/LevelSection.tscn"
const SAVE_PATH := "user://intro_seen.save"

# Try to find VideoStreamPlayer relative to this node.
@onready var video: VideoStreamPlayer = get_node_or_null("VideoStreamPlayer")

func _ready() -> void:
	# If the intro was already seen, skip immediately
	if has_intro_been_seen():
		go_to_world_selection()
		return

	# If the video node isn't where we expect it, print helpful error and skip
	if video == null:
		push_error("VideoStreamPlayer node not found at 'Story/VideoStreamPlayer'. " +
			"Check the node name/path or attach this script to the correct node.")
		go_to_world_selection()
		return

	# Play and connect to finished signal safely
	video.play()
	# Connect using Callable to avoid duplicate connections
	if not video.is_connected("finished", Callable(self, "_on_video_finished")):
		video.connect("finished", Callable(self, "_on_video_finished"))

func _on_video_finished() -> void:
	mark_intro_as_seen()
	go_to_world_selection()

func has_intro_been_seen() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func mark_intro_as_seen() -> void:
	var f := FileAccess.open(SAVE_PATH, FileAccess.ModeFlags.WRITE)
	if f:
		f.store_line("true")
		f.close()

func go_to_world_selection() -> void:
	# Ensure path is correct for your project
	var err := get_tree().change_scene_to_file("res://LevelSection.tscn")
	if err != OK:
		push_error("Failed to change scene to %s (err=%s)".format(WORLD_SCENE, str(err)))
