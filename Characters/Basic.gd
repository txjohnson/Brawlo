extends CharacterBody2D


var RUNSPEED = 340
var DASHSPEED = 390
var DASHTIME  = 10
var WALKSPEED = 200
var GRAVITY = 1000
var JUMPFORCE = 800
var MAX_JUMPFORCE = 800
var TRACTION = 40
var FALLSPEED = 60
var FALLINGSPEED = 900
var MAXFALLSPEED = 900

var frame = 0

func update_frames( delta ):
	frame += 1

func reset_frames():
	frame = 0

func turn( direction ):
	$Sprite.flip_h = direction

