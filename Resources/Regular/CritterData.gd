extends Resource
class_name CritterData


@export var critterName : String = ""
@export var scenePath : String = ""
@export var level : int = 1 :
	set(value):
		level = clamp(value,1,100)
@export var type : String = ""
@export var position : Vector2
@export var happiness : int  = 100 :
	set(value):
		happiness = clamp(value,0,100)
@export var levelProgress : int = 0 :
	set(value):
		if value > 6:
			levelProgress = 0
			level += 1
			increaseFoodAmount()
		else : 
			levelProgress = value
			

#How much it needs to be fed
@export var foodAmount : int = 20
	
@export var isHappy : bool = true

func increaseFoodAmount() -> void :
	if level < 5:
		foodAmount *= 2
	else :
		foodAmount *= 0.499 * pow(2.71828,-0.0461*level) + 1.001
