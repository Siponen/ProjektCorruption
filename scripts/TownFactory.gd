extends Node

const town = preload("res://prefabs/Town.tscn")

func build_town(name, owner):
	var newTown = town.instance()
	newTown.townName = name
	newTown.factionOwner = owner
	return newTown