extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	State.connect("time_passed", update_time_text)
	Manager.connect("funds_changed_up", update_funds_up_text)
	Manager.connect("funds_changed_down", update_funds_down_text)

	$TopLeft/DayNumber.text = str(State.current_day)
	$TopLeft/Time.text = State.get_formatted_time()
	$TopRight/MoneyLabel.text = str(Manager.funds)

func update_time_text():
	$TopLeft/DayNumber.text = str(State.current_day)
	$TopLeft/Time.text = State.get_formatted_time()

func update_funds_up_text():
	$AnimationPlayer.play("add_funds")
	$TopRight/MoneyLabel.text = str(Manager.funds)

func update_funds_down_text():
	var tween = get_tree().create_tween()
	tween.tween_property($TopRight/MoneyLabel, "modulate", Color.RED, 0.5)
	$TopRight/MoneyLabel.text = str(Manager.funds)
	tween.tween_property($TopRight/MoneyLabel, "modulate", Color.WHITE, 0.1)
