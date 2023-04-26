extends Node


## Scene loaded when starting the game
@export var first_scene: PackedScene


func _ready():
	assert(first_scene != null, "[MainMenuManager] first_scene is not set on %s" % get_path())

	# Disable input during fade in
	_set_disable_input(true)
	await TransitionScreen.fade_in_async()
	_set_disable_input(false)


func _on_main_menu_start_game_pressed():
	# Disable input during transition
	_set_disable_input(true)
	await SceneManager.change_scene_with_fade_async(first_scene)
	_set_disable_input(false)


func _set_disable_input(value: bool):
	get_tree().get_root().set_disable_input(value)
