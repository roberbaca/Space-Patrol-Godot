extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween. EASE_IN_OUT

export (float) var frequency = 15
export (int) var amplitude = 8
export (float) var duration = 0.2

onready var camera = get_parent()

# funcion para iniciar el shake effect
func start():
	self.amplitude = amplitude
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	$Duration.start()
	$Frequency.start()
	newShake()

func newShake():
	# definimos el vector para mover la camara
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()

func _on_Frequency_timeout():
	newShake()

func _on_Duration_timeout():
	reset()
	$Frequency.stop()
