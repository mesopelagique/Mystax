
Class extends Section

Class constructor($template : Text; $section : Text; $parser : 4D:C1709.Function)
	Super:C1705($template; $section; $parser)
	
Function render($data : Object)->$result : Text
	var $value : Variant
	$value:=$data[This:C1470.section]
	var $node : Object
	
	Case of 
		: ($value=Null:C1517)
			$result:=This:C1470.renderNodes(New object:C1471())
		: (Value type:C1509($value)=Is collection:K8:32)
			If ($value.length=0)
				$result:=This:C1470.renderNodes(New object:C1471())
			Else 
				$result:=""
			End if 
			
		: (Value type:C1509($value)=Is object:K8:27)
			
			If (OB Instance of:C1731($value; 4D:C1709.EntitySelection))
				
				If ($value.length=0)
					$result:=This:C1470.renderNodes(New object:C1471())
				Else 
					$result:=""
				End if 
				
			Else 
				$result:=""
			End if 
			
		: (Value type:C1509($value)=Is boolean:K8:9)
			
			If (Not:C34($value))
				$result:=This:C1470.renderNodes(New object:C1471())
			Else 
				$result:=""
			End if 
			
		Else 
			$result:=""
	End case 
	
Function 