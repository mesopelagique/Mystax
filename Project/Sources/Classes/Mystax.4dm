
/*
 Create a parser to use later
*/
Function parser($text : Text) : cs:C1710.Parser
	$0:=cs:C1710.Parser.new($text)
	
/*
 Create a parser with template already compiled.
*/
Function parse($text : Text) : cs:C1710.Parser
	$0:=This:C1470.parser($text).compile()
	
/* 
Parse the template and render directly.
	
For performance if you need to use same template multiple times (ex: user http web request),
use `parser` function instead and keep an instance of compiled template.
*/
Function render($text : Text; $data : Object) : Text
	$0:=This:C1470.parse($text).render($data)