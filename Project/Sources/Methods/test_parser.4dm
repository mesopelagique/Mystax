//%attributes = {}
var $template : Text
var $parser : cs:C1710.Parser
var $nodeCount : Integer


// simple text
$template:="simple text"
$nodeCount:=1
$parser:=cs:C1710.Parser.new($template)
$parser.compile()
ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129($parser.render(New object:C1471())=$template)


// simple var
$template:="{{simplevar}}"
$nodeCount:=1
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Var))
ASSERT:C1129($parser.render(New object:C1471())="")
ASSERT:C1129($parser.render(New object:C1471("simplevar"; "value"))="value")


// one var in text
$template:="simple text{{simplevar}}simple text"
$nodeCount:=3
$parser:=cs:C1710.Parser.new($template)
$parser.compile()


ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[1]; cs:C1710.Var))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[2]; cs:C1710.Text))
ASSERT:C1129($parser.render(New object:C1471())="simple textsimple text")
ASSERT:C1129($parser.render(New object:C1471("simplevar"; "value"))="simple textvaluesimple text")

// many vars
$template:="simple text{{simplevar}}{{secondvar}}simple text{{thirdvar}}"
$nodeCount:=5
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[1]; cs:C1710.Var))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[2]; cs:C1710.Var))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[3]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[4]; cs:C1710.Var))
ASSERT:C1129($parser.render(New object:C1471())="simple textsimple text")
ASSERT:C1129($parser.render(New object:C1471("simplevar"; "value"))="simple textvaluesimple text")
ASSERT:C1129($parser.render(New object:C1471("simplevar"; "value"; "thirdvar"; 3))="simple textvaluesimple text3")
ASSERT:C1129($parser.render(New object:C1471("simplevar"; "value"; "secondvar"; "test"; "thirdvar"; 3))="simple textvaluetestsimple text3")

// with point
$template:="{{object.var}}"
$nodeCount:=1
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Var))
ASSERT:C1129($parser.render(New object:C1471())="")
ASSERT:C1129($parser.render(New object:C1471("object"; New object:C1471("var"; "value")))="value")


// section bool
$template:="Shown.{{#person}}Never shown!{{/person}}"
$nodeCount:=2
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[1]; cs:C1710.Section))
ASSERT:C1129($parser.render(New object:C1471())="Shown.")
ASSERT:C1129($parser.render(New object:C1471("person"; False:C215))="Shown.")
ASSERT:C1129($parser.render(New object:C1471("person"; True:C214))="Shown.Never shown!")


// section coll
$template:="Show:\n{{#persons}}*{{name}}\n{{/persons}}"
$nodeCount:=2
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[1]; cs:C1710.Section))
ASSERT:C1129($parser.render(New object:C1471())="Show:\n")
ASSERT:C1129($parser.render(New object:C1471("persons"; New collection:C1472(New object:C1471("name"; "test"))))="Show:\n*test\n")
ASSERT:C1129($parser.render(New object:C1471("persons"; New collection:C1472(New object:C1471("name"; "test"); New object:C1471("name"; "test2"))))="Show:\n*test\n*test2\n")


// section coll with direct value
$template:="Show:\n{{#persons}}*{{}}\n{{/persons}}"
$nodeCount:=2
$parser:=cs:C1710.Parser.new($template)
$parser.compile()

ASSERT:C1129($parser.nodes.length=$nodeCount; "No correct number of nodes founds for "+$template+". Expected "+String:C10($nodeCount)+" but have "+JSON Stringify:C1217($parser.nodes))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[0]; cs:C1710.Text))
ASSERT:C1129(OB Instance of:C1731($parser.nodes[1]; cs:C1710.Section))
ASSERT:C1129($parser.render(New object:C1471())="Show:\n")
ASSERT:C1129($parser.render(New object:C1471("persons"; New collection:C1472("test")))="Show:\n*test\n")
ASSERT:C1129($parser.render(New object:C1471("persons"; New collection:C1472("test"; "test2")))="Show:\n*test\n*test2\n")




