
Class extends Section

Class constructor($template : Text; $section : Text; $parser : 4D:C1709.Function)
	Super:C1705($template; $section; $parser)
	
Function render($data : Object)->$result : Text
	var $value : Variant
	$value:=$data[This:C1470.section]
	var $node : Object
	
	Case of 
		: ($value=Null:C1517)
			$result:=""
			For each ($node; This:C1470.nodes)
				$result:=$result+$node.render($data)
			End for each 
		: (Value type:C1509($value)=Is boolean:K8:9)
			If (Not:C34($value))
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