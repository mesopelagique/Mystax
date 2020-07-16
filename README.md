# Mystax

[Mustache](https://en.wikipedia.org/wiki/Mustache_(template_system)) is a web template system, which use heavily braces `{ }`

## Usage

Create the parser for your template (`Text` variable) and compile it only one time.

```4d
$parser:=cs.Parser.new($template) // with $template a Text variable
$parser.compile()
````

Then render the result by passing data as `Object`

```4d
$result:=$parser.render(New object("world"; "Eric"))
```
`$result` will be "Hello Eric" for template "Hello {{world}}"

### Section tag

A section tag allow you to display or not some text.

```mustache
Shown.{{#person}}Never shown!{{/person}}
```

Then using 4D, to not display with `False`:

```4d
$parser.render(New object("person";False))
```
This will ouput "Shown."

And with `True`:

```4d
$parser.render(New object("person";True))
```
This will output "Shown.Never shown!"

## Saguinus mystax

![Saguinus mystax](https://live.staticflickr.com/4070/4483628891_b78f842f67_b.jpg)
