extends CharacterBody2D

@onready var Sprite = $Visual/Sprite

@export var player_num = 1

@onready var Action = $Action
@onready var Frame = $Frame

@onready var GroundL = $RayCasts/GroundL
@onready var GroundR = $RayCasts/GroundR

@onready var LedgeGrabF = $RayCasts/LedgeGrabF
@onready var LedgeGrabB = $RayCasts/LedgeGrabB


func turn( direction ):
	Sprite.flip_h = direction

