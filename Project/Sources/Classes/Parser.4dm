


Class constructor($template : Text)
	This:C1470.template:=$template
	
Function compile()
	This:C1470.nodes:=New collection:C1472()
	This:C1470._compile(This:C1470.template)
	
Function _compile($currentText : Text)
	If (Length:C16($currentText)>0)
		var $tmpText : Text
		var $pos : Integer
		$pos:=Position:C15("{{"; $currentText)
		
		If ($pos>0)
			
			$tmpText:=Substring:C12($currentText; 1; $pos-1)
			$currentText:=Substring:C12($currentText; $pos+2)
			$pos:=Position:C15("}}"; $currentText)
			
			If ($pos>0)  // we have a keyword
				
				If (Length:C16($tmpText)>0)
					This:C1470.nodes.push(cs:C1710.Text.new($tmpText))  // previous data as text if any
				End if 
				
				$tmpText:=Substring:C12($currentText; 1; $pos-1)
				$currentText:=Substring:C12($currentText; $pos+2)
				
				If (Position:C15("#"; $tmpText)=1)  // is it section ?
					
					$tmpText:=Substring:C12($tmpText; 2)  // remove section prefix
					$pos:=Position:C15("{{/"+$tmpText+""; $currentText)  // section end?
					
					If ($pos>0)  // we have a keyword
						
						$sectionText:=Substring:C12($currentText; 1; $pos-1)
						This:C1470.nodes.push(cs:C1710.Section.new($sectionText; $tmpText))
						
						$currentText:=Substring:C12($currentText; $pos+Length:C16($sectionText)+2)
						
					Else 
						// BAD ASSERT?
						
					End if 
					
				Else 
					This:C1470.nodes.push(cs:C1710.Var.new($tmpText))
				End if 
				
				// Go on
				This:C1470._compile($currentText)
				
			Else 
				
				This:C1470.nodes.push(cs:C1710.Text.new($tmpText+$currentText))  // all text, no keyword
				
			End if 
			
		Else 
			
			This:C1470.nodes.push(cs:C1710.Text.new($currentText))
			
		End if 
	End if 
	
	
Function render($data : Object) : Text
	var $node : cs:C1710.Node
	$0:=""
	For each ($node; This:C1470.nodes)
		$0:=$0+$node.render($data)
	End for each 
	
	