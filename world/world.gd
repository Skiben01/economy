extends Node2D
 
## The Node2D the world takes place in.

@onready var ground: TileMapLayer = %Ground

## The noise the world is build upon.
@export var noise: Noise

@export_range(-1.0, 1.0, 0.001) var threashold: float : set = set_range

func _ready():
	generate_world()

## Generates the world
func generate_world() -> void:
	var world_size: Vector2i = ProjectSettings.get_setting_with_override("game/settings/world_size")
	
	# Clear and regenrate tiles.
	for x in range(world_size.x):
		for y in range(world_size.y):
			var sample: float = noise.get_noise_2d(x, y) 
			var is_water: bool = sample >= threashold
			BetterTerrain.set_cell(ground, Vector2i(x, y), 0 if is_water else 1)
			
			if sample <= threashold - 0.35 and not is_water:
				BetterTerrain.set_cell(ground, Vector2i(x, y), 2)
	
	# Updates terrain connections
	BetterTerrain.update_terrain_area(ground, Rect2i(0,0, world_size.x, world_size.y))


## Sets the threashold between water and grass
func set_range(value: float):
	threashold = value
	if not is_node_ready():
		await self.ready
	
	generate_world()
