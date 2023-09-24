extends Node

signal funds_changed_up()
signal funds_changed_down()

# The Manager global keeps track of all things related to the Manager (You)
var funds
var players = []

# Called when the node enters the scene tree for the first time.
func _ready():
	funds = 10000

func add_funds(amount: int) -> void:
	funds += amount
	funds_changed_up.emit()

func subtract_funds(amount: int) -> void:
	funds -= amount
	funds_changed_down.emit()


