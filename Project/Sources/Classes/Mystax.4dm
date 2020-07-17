
/*
 Create a parser to use later
*/
Function parser($text : Text)->$parser : cs:C1710.Parser
	$parser:=cs:C1710.Parser.new($text)
	
/*
 Create a parser with template already compiled.
*/
Function parse($text : Text)->$parser : cs:C1710.Parser
	$parser:=This:C1470.parser($text).compile()
	
/* 
Parse the template and render directly.
	
For performance if you need to use same template multiple times (ex: user http web request),
use `parser` function instead and keep an instance of compiled template.
*/
Function render($template : Text; $data : Object)->$result : Text
	$result:=This:C1470.parse($template).render($data)