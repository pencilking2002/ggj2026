extends Control

#functions for sound effects

func play_sound_mask():
	$SoundMask.play()

func play_sound_mask_with_ramp_up(volume_ramp_up_duration:float):
	var tween: Tween = create_tween()
	tween.tween_property($SoundMask, "volume_db", linear_to_db(0.25), volume_ramp_up_duration).from(linear_to_db(0.001))
	$SoundMask.play()

func play_sound_pills():
	$Pills.play()

func stop_sound_pills():
	$Pills.stop()
	
func play_sound_radiation():
	$Radiationtouch.play()

func stop_sound_radiation():
	$Radiationtouch.stop()
	
func play_sound_worm_scream():
	$Wormscream.play()

func stop_sound_worm_scream():
	$Wormscream.stop()
	






func play_sound_geiger_single(max_variance : float = 0.0):
	$GeigerSingle.pitch_scale = 1.0 + randf() * max_variance
	$GeigerSingle.play()
	
func stop_sound_geiger_single():
	$GeigerSingle.stop()

func play_sound_geiger_fast():
	$GeigerFast.play()

func stop_sound_geiger_fast():
	$GeigerFast.stop()
	
func play_sound_geiger_medium():
	$GeigerMedium.play()

func stop_sound_geiger_medium():
	$GeigerMedium.stop()

func play_sound_geiger_slow():
	$GeigerSlow.play()

func stop_sound_geiger_slow():
	$GeigerSlow.stop()


#functions for music
func play_menu_music(volume_ramp_up_duration:float):
	var tween: Tween = create_tween()
	tween.tween_property($MenuMusic, "volume_db", linear_to_db(0.5), volume_ramp_up_duration).from(linear_to_db(0.001))
	$MenuMusic.play()

func stop_menu_music():
	$MenuMusic.stop()

func play_level_music():
	$LevelMusic.play()

func stop_level_music():
	$LevelMusic.stop()

func play_gameover_music():
	$GameOverMusic.play()

func stop_gameover_music():
	$GameOverMusic.stop()
