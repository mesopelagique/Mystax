
Class extends Node

Class constructor($template : Text)
	Super:C1705($template)
	
Function compile()
	This:C1470.nodes:=New collection:C1472()
	This:C1470.static_compile(This:C1470.template; This:C1470.nodes)
	
	
Function render($data : Object) : Text
	var $node : cs:C1710.Node
	$0:=""
	For each ($node; This:C1470.nodes)
		$0:=$0+$node.render($data)
	End for each 
	
	