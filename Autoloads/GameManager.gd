extends Node

var soulCoins : int 
var soulGems : int


var currentState : State = State.DEFAULT


var objectToPlace : String = ""
var critterToPlace : String = ""


enum State {
	DEFAULT,
	CRITTER_PLACING,
	OBJECT_PLACING
}

func toggleState(state : State):
	currentState = state
	

	



	
