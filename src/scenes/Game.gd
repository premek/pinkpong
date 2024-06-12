extends Node2D

var next_ball_start = Vector2(1,1)
var players = []
@export var win_score = 2
@export var current_level = 0
var levels = []
var levels_dir = "res://scenes/levels/"

func _ready():
	randomize()
	load_levels()
	$HUD/StartButton.connect("pressed", Callable(self, "start").bind(0))
	set_players()
	
func load_levels():
	var dir = DirAccess.open(levels_dir)
	dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			levels.append(load(levels_dir + file))
	dir.list_dir_end()
	
func set_players():
	players = [$CurrentLevel/Player1, $CurrentLevel/Player2]
	for i in range(0, players.size()):
		players[i].connect("score", Callable(self, "start").bind(i))

func start(scoring_player_index):
	$HUD/ScoreLabel.text = str(players[0].score1)
	for i in range(1, players.size()):
		$HUD/ScoreLabel.text += " : " + str(players[i].score1)
	$HUD/StartButton.hide()
	
	var max_score = 0
	for player in players: 
		if player.score1 > max_score: max_score = player.score1
#
	if max_score >= win_score: next_level()

	$CurrentLevel/Ball.velocity = Vector2(0,0)
	$CurrentLevel/Ball.start($CurrentLevel/BallStartPosition.position)
	# start aiming at the losing player in next round
	next_ball_start = ($CurrentLevel/Ball.position - players[scoring_player_index].position).normalized()
	next_ball_start.y = (randi()%2)*2-1
	$StartTimer.start()

func _on_StartTimer_timeout():
	$CurrentLevel/Ball.velocity = next_ball_start
	
func next_level():
	var level = $CurrentLevel
	remove_child(level)
	level.call_deferred("free")
	current_level = (current_level + 1) % levels.size()
	var next_level = levels[current_level].instantiate()
	add_child(next_level)
	next_level.name = "CurrentLevel"
	set_players()
