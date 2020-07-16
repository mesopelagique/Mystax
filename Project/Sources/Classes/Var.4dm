Class extends Node

Class constructor($template : Text)
	Super:C1705($template)
	This:C1470.keyPath:=Split string:C1554($template; ".")
	
Function render($data : Variant) : Text
	var $currentData : Variant
	$currentData:=$data
	
	var $key : Text
	For each ($key; This:C1470.keyPath)
		$currentData:=$currentData[$key]
	End for each 
	
	If ($currentData=Null:C1517)
		If (Length:C16(This:C1470.template)>0)
			$currentData:=$data[This:C1470.template]  // be gentle try to find with 
		Else 
			$currentData:=$data  // support {{}}
		End if 
	End if 
	
	Case of 
		: ((Value type:C1509($currentData)=Is text:K8:3)\
			 | (Value type:C1509($currentData)=Is boolean:K8:9)\
			 | (Value type:C1509($currentData)=Is integer:K8:5)\
			 | (Value type:C1509($currentData)=Is longint:K8:6)\
			 | (Value type:C1509($currentData)=Is real:K8:4)\
			 | (Value type:C1509($currentData)=Is integer 64 bits:K8:25))
			$0:=String:C10($currentData)
		: ((Value type:C1509($currentData)=Is object:K8:27) | (Value type:C1509($currentData)=Is collection:K8:32))
			$0:=JSON Stringify:C1217($currentData)
		Else 
			$0:=String:C10($currentData)  // try...
	End case 