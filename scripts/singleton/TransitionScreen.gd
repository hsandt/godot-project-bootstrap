extends CanvasLayer


@export var animation_player: AnimationPlayer


### Fade in screen
### This should not be called during another fade in/out
func fade_in(animation_speed: float = 1.0):
	if not animation_player.current_animation.is_empty():
		push_warning("[TransitionScreen] fade_in: animation '%s' " %
			animation_player.current_animation,
			"is already playing. We will still play 'fade_in', but previous ",
			"async calls may be delayed as they are waiting for animation end.")

	animation_player.play(&"fade_in", -1, animation_speed)


### Fade out screen
### This should not be called during another fade in/out
func fade_out(animation_speed: float = 1.0):
	if not animation_player.current_animation.is_empty():
		push_warning("[TransitionScreen] fade_out: animation '%s' " %
			animation_player.current_animation,
			"is already playing. We will still play 'fade_out', but previous ",
			"async calls may be delayed as they are waiting for animation end.")

	animation_player.play(&"fade_out", -1, animation_speed)


### Fade in screen and await for animation end
### This should not be called during another fade in/out
func fade_in_async(animation_speed: float = 1.0):
	fade_in(animation_speed)

	# At this point, we know that the 'fade_in' animation is being played,
	# and the user should not try to play another animation to interrupt this one,
	# so we can just await animation_finished signal instead of doing a full check
	# with an animation_finished callback + check animation name => emit custom finish signal.
	# This allows the user to await this method directly instead of awaiting a custom signal.
	await animation_player.animation_finished


### Fade out screen and await for animation end
### This should not be called during another fade in/out
func fade_out_async(animation_speed: float = 1.0):
	fade_out(animation_speed)

	# Same remark as fade_in_async
	await animation_player.animation_finished
