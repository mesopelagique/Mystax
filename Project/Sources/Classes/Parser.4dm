
Class extends Node

Class constructor($template : Text)
	Super:C1705($template)
	
Function compile()->$this : cs:C1710.Parser
	This:C1470.nodes:=New collection:C1472()
	This:C1470.static_compile(This:C1470.template; This:C1470.nodes)
	$this:=This:C1470
	
Function render($data : Object)->$result : Text
	var $node : cs:C1710.Node
	$result:=""
	ASSERT:C1129(This:C1470.nodes#Null:C1517; "Parser as not been compiled")
	For each ($node; This:C1470.nodes)
		$result:=$result+$node.render($data)
	End for each 
	