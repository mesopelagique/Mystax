
Class constructor($template : Text)
	This:C1470.template:=$template
	
Function render($data : Object)->$result : Text
	$result:=This:C1470.template
	
Function static_compile($currentText : Text; $nodes : Collection)
	If (Length:C16($currentText)>0)
		var $tmpText; $sectionText : Text
		var $pos : Integer
		$pos:=Position:C15("{{"; $currentText)
		
		If ($pos>0)
			
			$tmpText:=Substring:C12($currentText; 1; $pos-1)
			$currentText:=Substring:C12($currentText; $pos+2)
			$pos:=Position:C15("}}"; $currentText)
			
			If ($pos>0)  // we have a keyword
				
				If (Length:C16($tmpText)>0)
					$nodes.push(cs:C1710.Text.new($tmpText))  // previous data as text if any
				End if 
				
				$tmpText:=Substring:C12($currentText; 1; $pos-1)
				$currentText:=Substring:C12($currentText; $pos+2)
				
				var $first : Text
				If (Length:C16($tmpText)>0)
					$first:=$tmpText[[1]]
				Else 
					$first:=""
				End if 
				
				Case of 
					: (($first="#") | ($first="^"))  // is it section ?
						
						$tmpText:=Substring:C12($tmpText; 2)  // remove section prefix
						$pos:=Position:C15("{{/"+$tmpText+"}}"; $currentText)  // section end?
						
						If ($pos>0)  // we have a keyword
							
							$sectionText:=Substring:C12($currentText; 1; $pos-1)
							If ($first="#")
								$nodes.push(cs:C1710.Section.new($sectionText; $tmpText; This:C1470.static_compile))
							Else 
								$nodes.push(cs:C1710.InvertedSection.new($sectionText; $tmpText; This:C1470.static_compile))
							End if 
							$currentText:=Substring:C12($currentText; $pos+Length:C16($tmpText)+5)
							
						Else 
							// BAD ASSERT?
							// ASSERT(False; "Missing session close {{/"+$tmpText+"}}")
						End if 
						
					: ($first="!")  // is ignore node
						$nodes.push(cs:C1710.Ignore.new($tmpText))
					Else 
						$nodes.push(cs:C1710.Var.new($tmpText))
				End case 
				
				// Go on
				This:C1470.static_compile($currentText; $nodes)
				
			Else 
				
				$nodes.push(cs:C1710.Text.new($tmpText+$currentText))  // all text, no keyword
				
			End if 
			
		Else 
			
			$nodes.push(cs:C1710.Text.new($currentText))
			
		End if 
	End if 
	