extends Control

#functions for sound effects

func play_sound_mask():
	$SoundMask.play()

func play_sound_mask_with_ramp_up(volume_ramp_up_duration:float):
	var tween: Tween = create_tween()
	tween.tween_property($SoundMask, "volume_db", linear_to_db(0.5), volume_ramp_up_duration).from(linear_to_db(0.001))
	$SoundMask.play()
