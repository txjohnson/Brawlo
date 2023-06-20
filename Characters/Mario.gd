extends CharacterBody2D

@onready var GroundL = $Raycasts/GroundL
@onready var GroundR = $Raycasts/GroundR
@onready var Anim = $Sprite/Animator
@onready var StateName = $StateName
@onready var FrameNum = $FrameNum


var RUNSPEED = 400
var DASHSPEED = 500
var DASHTIME  = 10
var WALKSPEED = 200
var GRAVITY = 600
var JUMPFORCE = 900
var MAX_JUMPFORCE = 1200
var FALLSPEED = 50
var MAX_FALLSPEED = 900
var MAXFALLSPEED = 900
var SQUATTIME  = 3
var TRACTION = 40
var AIR_ACCEL = 5
var AIR_DODGE_SPEED = 500


var frame = 0
var landing_frame = 0
var lag_frame = 0
var fastfall :bool = false
var down_buffer = 1

func update_frame( delta ):
	$FrameNum.text = str(frame)
	frame += 1

func reset_frame():
	frame = 0

func turn( direction ):
	$Sprite.flip_h = direction

func _physics_process(delta):
	pass

func _ready():
	floor_snap_length = 0.0

func play_animation(name):
	Anim .play(name)
	pass
