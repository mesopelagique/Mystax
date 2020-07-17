
Class extends Node

Class constructor($template : Text; $section : Text; $parser : 4D:C1709.Function)
	Super:C1705($template)
	This:C1470.section:=$section
	This:C1470.nodes:=New collection:C1472()
	
	$parser.call(This:C1470; $template; This:C1470.nodes)
	
Function render($data : Object)->$result : Text
	var $value : Variant
	$value:=$data[This:C1470.section]
	var $node : Object
	Case of 
		: (Value type:C1509($value)=Is collection:K8:32)
			
			var $next : Variant
			$result:=""
			For each ($next; $value)
				For each ($node; This:C1470.nodes)
					If (Value type:C1509($next)=Is object:K8:27)
						$result:=$result+$node.render($next)
					Else 
						If (OB Instance of:C1731($node; cs:C1710.Var))
							$result:=$result+$node.render($next)
						Else 
							$result:=$result+$node.render(New object:C1471(""; $next))
						End if 
					End if 
				End for each 
				
			End for each 
			
		: (Value type:C1509($value)=Is boolean:K8:9)
			If ($value)
				$result:=""
				For each ($node; This:C1470.nodes)
					$result:=$result+$node.render($data)
				End for each 
			Else 
				$result:=""
			End if 
			
		Else 
			$result:=""
	End case 