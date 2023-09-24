extends Node

enum RarityNames {COMMON = 1, SPECIAL = 2, EXCEPTIONAL = 3, LEGENDARY = 4, UNIQUE = 5}
enum Roles {TOP = 0, JUNGLE = 1, MIDDLE = 2, BOTTOM = 3, SUPPORT = 4}

var player_scene: PackedScene = preload("res://Characters/player.tscn")

var player_list = []
var female_first_names = []
var male_first_names = []
var last_names = []
var nouns = []
var adjectives = []
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

var current_hour: int
var current_day: int


# signals
signal time_passed()

func _ready():
	load_file("res://Data/female.txt", female_first_names)
	load_file("res://Data/male.txt", male_first_names)
	load_file("res://Data/last_names.txt", last_names)
	load_file("res://Data/nounlist.txt", nouns)
	load_file("res://Data/english-adjectives.txt", adjectives)
	current_hour = 1
	current_day = 1

func pass_time(hours: int) -> void:
	current_hour += hours
	if(current_hour >= 24):
		current_hour = current_hour % 24
		current_day += 1
	time_passed.emit()

func get_formatted_time() -> String:
	var prefix = current_hour
	var suffix = "AM"
	if(current_hour > 12):
		prefix = current_hour - 12
		suffix = "PM"
	return str(prefix) + ":00 " + suffix

func generate_random_rarity() -> RarityNames:
	var rng = randi_range(0,100)
	print(rng)
	if(rng >= 95):
		return RarityNames.LEGENDARY
	elif(rng >= 75):
		return RarityNames.EXCEPTIONAL
	elif(rng >= 55):
		return RarityNames.SPECIAL
	else:
		return RarityNames.COMMON

func generate_random_player(rarity: RarityNames = RarityNames.COMMON):
	var player = player_scene.instantiate() as PlayerParent
	player.rarity = rarity
	player.player_id = str(player_list.size() + 1)
	player.male = (randf() > 0.5)
	if player.male:
		player.player_first_name = generate_random_name(male_first_names).to_upper()
		player.portrait_number = randi_range(1,3)
	else:
		player.player_first_name = generate_random_name(female_first_names)	.to_upper()
		player.portrait_number = 4
	player.player_last_name = generate_random_name(last_names).to_upper()

	player.player_handle = generate_gamer_tag(randi_range(0,3))
	player.birthday = generate_birthday(rarity)
	generate_n_stats(player, 4, rarity)

	player_list.append(player)
	pass_time(3)
	return player

func assign_role(player_id, role: Roles):
	var player = player_list[player_id - 1]
	player.role = role

func generate_random_player_with_role(role: Roles, rarity: RarityNames = RarityNames.COMMON):
	var player = generate_random_player(rarity)
	player.role = role
	return player


func generate_stats_with_rarity(rarity: int) -> int:
	var stat = 0
	var multiplier: float = 1 + float(rarity)/10
	# base level = random int between 0-5
	stat += randi_range(10,40)
	# rarity bonus
	stat += randi_range(rarity,rarity*8)

	# legendary bonus
	if(rarity >= 4):
		stat += rarity * 2
	# rarity multiplier
	stat *= multiplier
	return stat

# generates num_stats number of stats. Excess stat points are given to lower stats. Then assigns stats to player
func generate_n_stats(player, num_stats, rarity: int = 1) -> void:
	var surplus = 0
	var generated_stats = []
	for i in num_stats:
		var generated = generate_stats_with_rarity(rarity)
		if(generated > 100):
			surplus = generated - 100
			generated_stats.append(100)
		elif(generated + surplus > 100):
			surplus = generated + surplus - 100
			generated_stats.append(100)
		else:
			generated_stats.append(generated + surplus)
			surplus = 0

	player.laning = generated_stats[0]
	player.teamwork = generated_stats[1]
	player.consistency = generated_stats[2]
	player.confidence = generated_stats[3]


func generate_random_name(list: Array) -> String:
	return list[randi_range(0, list.size()-1)]

func load_file(file_name: String, list: Array) -> void:
	var file = FileAccess.open(file_name, FileAccess.READ)
	while not file.eof_reached():
		list.append(file.get_line())

func generate_gamer_tag(tag_type: int):
	var gamer_tag: String = ""

	# LETTER LETTER ADJECTIVE (TKBREEZY, LLSTYLISH)
	if (tag_type == 0):
		gamer_tag += alphabet.substr(randi_range(0,25), 1)
		gamer_tag += alphabet.substr(randi_range(0,25), 1)

		var connection_type = randi_range(0,2)
		if connection_type == 0:
			gamer_tag += "_"
		elif connection_type == 1:
			gamer_tag += "-"
		else:
			gamer_tag += ""
		gamer_tag += adjectives[randi_range(0, adjectives.size() - 1)];
		return gamer_tag

	# SINGLE WORD (FAKER, DEFT, ROOKIE)
	elif (tag_type == 1):
		var word_type = randi_range(0,1)
		if word_type == 0:
			gamer_tag += nouns[randi_range(0, nouns.size() - 1)].to_upper()
			return gamer_tag
		else:
			gamer_tag += adjectives[randi_range(0, adjectives.size() - 1)].to_upper()
			return gamer_tag

	#REPEATED NOUN (MOONMOON)
	elif (tag_type == 2):
		var n: String = nouns[randi_range(0, nouns.size())].to_upper()
		gamer_tag += n;
		if (n.length() < 5):
			gamer_tag += n;
			return gamer_tag
		else:
			return gamer_tag

	# ADJECTIVE NOUN NUMBER (BigCat69)
	elif (tag_type == 3):
		gamer_tag += adjectives[randi_range(0, adjectives.size())];
		gamer_tag += nouns[randi_range(0, nouns.size())];
		var num_digits = randi_range(0,3)
		if (num_digits == 0):
			return gamer_tag
		elif(num_digits == 1):
			gamer_tag += str(randi_range(0,9))
			return gamer_tag
		elif(num_digits == 2):
			gamer_tag += str(randi_range(10,99))
			return gamer_tag
		elif(num_digits == 3):
			gamer_tag += str(randi_range(100,999))
			return gamer_tag

			# RANDOM LETTERS AND NUMBERS (Xyp9x, JJoNak)
	elif (tag_type == 4):
		var length = randi_range(3,9)
		for i in range(length):
			var letter = alphabet.substr(randi_range(0,25),1)
			if(randf() > 0.4):
				gamer_tag += letter.to_upper()
			else:
				gamer_tag += letter.to_lower()
		return gamer_tag
	else:
		return gamer_tag

func generate_birthday(rarity: int = 0):
	# first generate age in years
	var age_years: int = 0
	var birth_month = randi_range(1,12)
	var birth_day = randi_range(1, 28)
	var current_date: Dictionary = Time.get_date_dict_from_system()

	# outliers account for random super rare players who are either extremely young or old
	var outlier = randi_range(0,100)
	if outlier > (100 - rarity):
		age_years = randi_range(26, 110)
	elif outlier < rarity:
		age_years = randi_range(0, 15)
	else:
		age_years = randi_range(16,25)

	# birthday is generated by subtracting age (ymd) from current date
	current_date["year"] -= age_years
	current_date["month"] = birth_month
	current_date["day"] = birth_day
	return current_date

