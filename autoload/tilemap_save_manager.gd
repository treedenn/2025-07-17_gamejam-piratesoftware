extends Node

var level_tilemap_data: Dictionary = {}

func save_level_tilemaps(level_index: int, tilemap1: TileMapLayer, tilemap2: TileMapLayer):
	level_tilemap_data[level_index] = {
		"tilemap1_data": tilemap1.tile_map_data,
		"tilemap1_tileset": tilemap1.tile_set,
		"tilemap2_data": tilemap2.tile_map_data,
		"tilemap2_tileset": tilemap2.tile_set
	}
	print("Saved tilemap data for level ", level_index)

func restore_level_tilemaps(level_index: int, tilemap1: TileMapLayer, tilemap2: TileMapLayer):
	if level_index in level_tilemap_data:
		var data = level_tilemap_data[level_index]
		tilemap1.tile_map_data = data.tilemap1_data
		tilemap1.tile_set = data.tilemap1_tileset
		tilemap2.tile_map_data = data.tilemap2_data
		tilemap2.tile_set = data.tilemap2_tileset
		print("Restored tilemap data for level ", level_index)
	else:
		print("No saved tilemap data for level ", level_index)
