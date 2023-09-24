extends Control

var p1: Texture2D = load("res://Graphics/Portraits/1.jpg")
var p2: Texture2D = load("res://Graphics/Portraits/2.jpg")
var p3: Texture2D = load("res://Graphics/Portraits/3.jpg")
var p4: Texture2D = load("res://Graphics/Portraits/4.jpg")

var portraits = [p1,p2,p3,p4]

@onready var player_card: ColorRect = $CanvasLayer/ColorRect/ColorRect
@onready var player_portrait: Sprite2D = $CanvasLayer/ColorRect/Portrait
@onready var player_name_label: Label = $CanvasLayer/ColorRect/PlayerStats/PlayerName
@onready var player_handle_label: Label = $CanvasLayer/ColorRect/PlayerStats/PlayerHandle
@onready var birthday_label: Label = $CanvasLayer/ColorRect/PlayerStats/Birthday
@onready var age_label: Label = $CanvasLayer/ColorRect/PlayerStats/Age
@onready var role_label: Label = $CanvasLayer/ColorRect/PlayerStats/Role
@onready var rarity_label: Label = $CanvasLayer/ColorRect/ColorRect/Rarity


@onready var laning_label: TextureProgressBar = $CanvasLayer/ColorRect/PlayerStats/StatBars/Laning
@onready var teamwork_label: TextureProgressBar = $CanvasLayer/ColorRect/PlayerStats/StatBars/Teamwork
@onready var consistency_label: TextureProgressBar = $CanvasLayer/ColorRect/PlayerStats/StatBars/Consistency
@onready var confidence_label: TextureProgressBar = $CanvasLayer/ColorRect/PlayerStats/StatBars/Confidence


func _on_generate_button_down():
	var rarity = State.generate_random_rarity()
	var player = State.generate_random_player_with_role(randi_range(0,4), rarity) as PlayerParent
	change_player_card_rarity(rarity)
	change_player_portrait(randi_range(0,3))
	player_name_label.text = player.get_full_name()
	player_handle_label.text = player.player_handle
	birthday_label.text = player.get_birthday_string()
	age_label.text = str(player.get_age())
	role_label.text = player.get_role_string()
	rarity_label.text = player.get_rarity_string()
	laning_label.value = player.laning
	teamwork_label.value = player.teamwork
	consistency_label.value = player.consistency
	confidence_label.value = player.confidence

# Signals

func _on_print_players_button_down():
	print(State.player_list)

func _on_add_funds_button_down():
	Manager.add_funds(1000)

func _on_subtract_funds_button_down():
	Manager.subtract_funds(580)

func change_player_portrait(portrait_number):
	player_portrait.texture = portraits[portrait_number]
	player_portrait.scale = Vector2(0.3,0.3)

func change_player_card_rarity(rarity):
	if rarity == State.RarityNames.COMMON:
		player_card.color = Color8(131,131,131,255)
	elif rarity == State.RarityNames.SPECIAL:
		player_card.color = Color8(83,139,204,255)
	elif rarity == State.RarityNames.EXCEPTIONAL:
		player_card.color = Color8(100,72,145,255)
	elif rarity == State.RarityNames.LEGENDARY:
		player_card.color = Color8(167,116,31,255)


