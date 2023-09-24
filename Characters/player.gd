extends Node2D
class_name PlayerParent

var player_id: int
var player_first_name: String
var player_last_name: String
var player_handle: String
var male: bool
var birthday: Dictionary
var rarity: State.RarityNames
var role: State.Roles
var portrait_number: int

# I want players to be like rare items in Diablo
# chance of some OP players, a lot of mediocre stuff

# Intrinsic Stats (Outside of specific events, these stats will stay the same)
var charisma: int   # Helps with sponsorship deals, streaming revenue, gaining fans
var toxicity: int   # Negativity to both teammates and enemies, twitter drama, shit talking, etc
var work_ethic: int # Benefits Skill training
var loyalty: int    # high loyalty keeps players on teams, keeps players with teammates they like


# Skills [1-10] (These skills can be trained or upgraded in some way)
var laning: int
var teamwork: int
var consistency: int
var confidence: int

# Relationships (Dictionary of players and opinions of them)


# Secret stats (Like EVs/IVs in pokemon)
var clutch_factor: int
var creativity: int

func get_full_name() -> String:
	return player_first_name + " " + player_last_name

func get_birthday_string() -> String:
	return str(birthday["month"]) + "/" + str(birthday["day"]) + "/" + str(birthday["year"])

func get_age() -> int:
	var curr_date = Time.get_datetime_dict_from_system()
	var age = curr_date['year'] - birthday['year']
	if (curr_date['month'] >= birthday['month']) and curr_date['day'] >= birthday['day']:
			age += 1
	return age

func get_role_string() -> String:
	return State.Roles.keys()[role]

func get_rarity_string() -> String:
	return State.RarityNames.keys()[rarity - 1]
