extends Node2D

onready var global = get_node('/root/global');

const initial_spawn_position: Vector2 = Vector2(140, 57);
const cave_spawn_position: Vector2 = Vector2(392, 56);

func _ready():
  if global.door_name == 'cave_door':
    $YSort/player.position = cave_spawn_position;
