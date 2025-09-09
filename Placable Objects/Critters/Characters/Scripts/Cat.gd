extends Twins


func _ready() -> void:
	print(critterTrait)
	critterCardName = "CatCard"
	$CatSprite.play("default")
	super._ready()
