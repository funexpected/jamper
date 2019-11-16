extends Node

signal idle
signal fixed

const FORMAT_SECONDS_FULL = 0 
const FORMAT_SECONDS_NORMAL = 1
const FORMAT_SECONDS_TINY = 2

func _ready():
	get_tree().connect("idle_frame", self, "emit_signal", ["idle"])
	get_tree().connect("physics_frame", self, "emit_signal", ["fixed"])
	
func wait(time):
	yield(get_tree().create_timer(time), "timeout")

# wait with respect paused branch 
# of current (at the moment of call) screen
#func pwait(time, repeat=false):
#	yield(defer(), "completed")
#	var elem = ui.get_top_screen()
#	if !elem:
#		return yield(wait(time), "completed")
#	var timer = Timer.new()
#	elem.add_child(timer)
#	timer.one_shot = true
#	timer.start(time)
#	if repeat:
#		return timer
#	else:
#		yield(timer, "timeout")
#		timer.queue_free()
	
func now():
	return OS.get_unix_time()

func defer():
	var d = _Deferred.new()
	yield(d.process(), "completed")

func period_to_seconds(period):
	if typeof(period) == TYPE_INT || typeof(period) == TYPE_REAL:
		return float(period)
	var result = 0
	var amount = ""
	for index in range(period.length()):
		var ch = period.substr(index, 1)
		if ch == "." || ch.is_valid_integer():
			amount += ch
			continue
		elif ch == "s":
			result += amount.to_float()
		elif ch == "M":
			result += 60 * amount.to_float()
		elif ch == "h":
			result += 60 * 60 * amount.to_float()
		elif ch == "d":
			result += 60 * 60 * 24 * amount.to_float()
		elif ch == "w":
			result += 7 * 60 * 60 * 24 * amount.to_float()
		elif ch == "m":
			result += 28 * 60 * 60 * 24 * amount.to_float()
		amount = ""
	return max(0.1,result)

func format_now(format="%Y.%m.%d %H:%M:%S"):
	return format_time(OS.get_system_time_msecs()*0.001, format)
func format_time(time, format="%Y.%m.%d %H:%M:%S"):
# more in http://www.cplusplus.com/reference/ctime/strftime/
	var data = OS.get_datetime_from_unix_time(floor(time))
	var result = ""
	var i = 0
	var token = false
	while i < format.length():
		if format[i] == '%':
			token = true
			i += 1
			continue
		else:
			if token:
				match format[i]:
					'Y':
						result += "%04d" % data.year
					'm':
						result += "%02d" % data.month
					'd':
						result +="%02d" % data.day
					'H':
						result +="%02d" % data.hour
					'M':
						result +="%02d" % data.minute
					'S':
						result +="%02d" % data.second
					'f': # C# like, cuz it's missing but usefull
						result +="%03d" % (int(1000*time) % 1000)
					'z': # C# like, cuz it's more representative
						result +="%+02d:00" % (OS.get_time_zone_info().bias/60)
				token = false
			else:
				result += format[i]
		i += 1
	return result


class _Deferred:
	extends Reference
	signal defer
	
	func process():
		call_deferred("emit_signal", "defer")
		yield(self, "defer")