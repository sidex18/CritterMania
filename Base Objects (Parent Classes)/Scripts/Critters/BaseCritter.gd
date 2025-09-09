class_name BaseCritter
extends Node2D


var critterCardName : String
var dataToSave : CritterData
@export var animatedSprite : AnimatedSprite2D
@export var critterTrait : String
@export var decayRate : float


var checkHappinessState : Callable

func _ready() -> void:
	animatedSprite.play("default")
	

func _process(delta: float) -> void:
	if not dataToSave.isHappy:
		dataToSave.happiness -= 1
	
		



func updateHappiness(happy : bool) -> void :
	dataToSave.isHappy = happy
	if happy:
		dataToSave.happiness = 100
	

func feed() -> void :
	pass
	
func exitFeedScreen()-> void :
	pass
func dataload() -> void :
	dataToSave.position = self.global_position
