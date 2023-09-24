extends CanvasLayer
class_name PlayerCard

var player: PlayerParent

var p1: Texture2D = load("res://Graphics/Portraits/1.jpg")
var p2: Texture2D = load("res://Graphics/Portraits/2.jpg")
var p3: Texture2D = load("res://Graphics/Portraits/3.jpg")
var p4: Texture2D = load("res://Graphics/Portraits/4.jpg")

var portraits = [p1,p2,p3,p4]

@onready var player_card: ColorRect = $MainBG
@onready var player_portrait: TextureRect = $MainBG/Border/PortraitBorder/Portrait
@onready var player_name_label: Label = $MainBG/Border/Identity/VBoxContainer/PlayerName
@onready var player_handle_label: Label = $MainBG/Border/Identity/VBoxContainer/PlayerHandle
@onready var birthday_label: Label = $MainBG/Border/Identity/BirthdayContainer/Birthday
@onready var age_label: Label = $MainBG/Border/Identity/AgeContainer/Age
@onready var role_label: Label = $MainBG/Border/Role
@onready var rarity_label: Label = $MainBG/Border/Rarity
#
#
@onready var laning_bar: TextureProgressBar = $MainBG/Border/MainStats/LaningContainer/Node2D/LaningBar
@onready var teamwork_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/Teamwork
@onready var consistency_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/Consistency
@onready var confidence_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/Confidence
@onready var charisma_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/Charisma
@onready var toxicity_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/Toxicity
@onready var work_ethic_bar: TextureProgressBar = $MainBG/Border/PlayerStats/StatBars/WorkEthic

func _init(p: PlayerParent):
	player = p

func _ready():
	State.connect("player_updated", update_player_card_text)


func update_player_card_text(player_id):
	if player.player_id == player_id:
		change_player_card_rarity()
		change_player_portrait()
		player_name_label.text = player.get_full_name()
		player_handle_label.text = player.player_handle
		birthday_label.text = player.get_birthday_string()
		age_label.text = str(player.get_age())
		role_label.text = player.get_role_string()
		rarity_label.text = player.get_rarity_string()
		laning_bar.value = player.laning
		teamwork_bar.value = player.teamwork
		consistency_bar.value = player.consistency
		confidence_bar.value = player.confidence

func change_player_portrait():
	var portrait_number = player.portrait_number
	player_portrait.texture = portraits[portrait_number]
	player_portrait.scale = Vector2(0.3,0.3)

func change_player_card_rarity():
	var rarity = player.rarity
	if rarity == State.RarityNames.COMMON:
		player_card.color = Color8(131,131,131,255)
	elif rarity == State.RarityNames.SPECIAL:
		player_card.color = Color8(83,139,204,255)
	elif rarity == State.RarityNames.EXCEPTIONAL:
		player_card.color = Color8(100,72,145,255)
	elif rarity == State.RarityNames.LEGENDARY:
		player_card.color = Color8(167,116,31,255)

