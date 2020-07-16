
Class extends Node

Class constructor($template : Text; $section : Text)
	Super:C1705($template)
	This:C1470.section:=$section
	
	
Function render($data : Object) : Text
	If (Bool:C1537($data[This:C1470.section]))
		$0:=This:C1470.template
	Else 
		$0:=""
	End if 