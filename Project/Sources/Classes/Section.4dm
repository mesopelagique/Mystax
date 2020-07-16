
Class extends Node

Class constructor($template : Text; $section : Text; $parser : 4D:C1709.Function)
	Super:C1705($template)
	This:C1470.section:=$section
	This:C1470.nodes:=New collection:C1472()
	
	$parser.call(This:C1470; $template; This:C1470.nodes)
	
Function render($data : Object) : Text
	var $value : Variant
	$value:=$data[This:C1470.section]
	var $node : Object
	Case of 
		: (Value type:C1509($value)=Is collection:K8:32)
			
			var $next : Variant
			$0:=""
			For each ($next; $value)
				For each ($node; This:C1470.nodes)
					$0:=$0+$node.render($next)
				End for each 
				
			End for each 
			
		: (Value type:C1509($value)=Is boolean:K8:9)
			If ($value)
				$0:=""
				For each ($node; This:C1470.nodes)
					$0:=$0+$node.render($data)
				End for each 
			Else 
				$0:=""
			End if 
			
		Else 
			$0:=""
	End case 