extends Node


## Change scene safely at the end of the frame
func change_scene(new_scene: PackedScene):
	# Following the example in
	# https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html
	# we defer changing scene to avoid deleting nodes required by code currently running
	call_deferred("_change_scene_immediate", new_scene)


## Change scene with fade out screen and back in
func change_scene_with_fade_async(scene: PackedScene):
	await TransitionScreen.fade_out_async()
	# await should wait for end of frame, so we can safely call_change_scene_immediate here
	_change_scene_immediate(scene)
	await TransitionScreen.fade_in_async()


func _change_scene_immediate(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
