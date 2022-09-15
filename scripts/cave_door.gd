extends Area2D

export (String, FILE, "*.tscn, *.scn") var new_scene;

# export  (PackedScene) var next_scene; # ? does not work


onready var global = get_node("/root/global")

# Called when the node enters the scene tree for the first time.
func _ready():
  pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  if get_overlapping_bodies().size() > 0:
    nextLevel();

func nextLevel():
  var _ok = get_tree().change_scene(new_scene);
  global.door_name = name;
