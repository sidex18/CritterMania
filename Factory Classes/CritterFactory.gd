extends Node
class_name CritterFactory


static func restore(critterRes : CritterData) :
	var critterInstance = load(critterRes.scenePath).instantiate()
	critterInstance.dataToSave = critterRes
	return critterInstance		

static func create(critterPath : String) :
	var critterInstance = load(critterPath).instantiate()
	var res = CritterData.new()
	res.scenePath = critterPath
	critterInstance.dataToSave = res
	return critterInstance
