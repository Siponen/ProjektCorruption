extends Node

const unit = preload("res://prefabs/Unit.tscn")

func build_imp_unit():
	var imp = unit.instance()
	imp.unitName = "Imp"
	imp.unitOwner = "Player"
	return imp