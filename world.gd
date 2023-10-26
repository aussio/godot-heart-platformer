extends Node2D


@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D

# At the start of the game - when World is ready
func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon
