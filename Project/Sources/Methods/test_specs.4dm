//%attributes = {}

var $specsFolder:=Folder:C1567(fk database folder:K87:14).folder("Specs")
var $resultFolder:=$specsFolder.folder("Results")

var $file : 4D:C1709.File
For each ($file; $specsFolder.files())
	
	If (($file.extension=".json")\
		 && (String:C10($file.fullName[[1]])#"~"))
		
		var $spec; $test : Object
		$spec:=JSON Parse:C1218($file.getText())
		
		For each ($test; $spec.tests)
			
			$test.result:=mystax.render($test.template; $test.data)
			$test.success:=$test.result=$test.expected
			
			If ($resultFolder.exists)
				
				$resultFolder.folder(Choose:C955($test.success; "Success"; "Failure")).create()
				$resultFolder.folder(Choose:C955($test.success; "Success"; "Failure")).file($file.name+"-"+$test.name+".json").setText(JSON Stringify:C1217($test; *))
				
			Else 
				$test.familly:=$file.name
				ASSERT:C1129($test.success; JSON Stringify:C1217($test))
			End if 
			
		End for each 
	End if 
	
End for each 