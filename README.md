# Mystax

[Mustache](https://en.wikipedia.org/wiki/Mustache_(template_system)) is a [web template system](https://en.wikipedia.org/wiki/Web_template_system), which use heavily braces `{ }`, hence its name.

## Usage

Create a parser for one template (`Text` variable) and compile it (only one time).

```4d
$parser:=cs.Parser.new($template) // with $template a Text variable
$parser.compile()
````

Then render the result by passing the data you want to inject as `Object`.

For instance with this simple template:

```Handlebars
Hello {{world}}"
```

The result of code

```4d
$result:=$parser.render(New object("world"; "Eric"))
```

 will be 
 
 ```html
 Hello Eric
```

### Section tag

#### Conditionnal block

A section tag with `Boolean` allow you to display or not some text.

```Handlebars
Shown.{{#person}}Never shown!{{/person}}
```

Then using 4D, to not display the block by passing `False`:

```4d
$parser.render(New object("person";False))
```

the result will be only

```
Shown.
```

And with `True`:

```4d
$parser.render(New object("person";True))
```

the result will be

```html
Shown.Never shown!
```

#### Repeating block

Using a `Collection` of object you could repeat a section

For instance if a book have multiple authors:
```Handlebars
<h1>{{title}}</h1>
{{#author}}
  <h2>By {{name}}</h2>
{{/author}}
```

You can pass the list of authors as collection

```4d
$result:=$parser.render(New object("title"; "The Talisman"; \
"author"; New collection(New object("name"; "Peter Straub");New object("name"; "Stephen King"))))
```

and the result will be

```html
<h1>The Talisman</h1>
  <h2>By Peter Straub</h2>
  <h2>By Stephen King</h2>
```

## Saguinus mystax

![Saguinus mystax](https://live.staticflickr.com/4070/4483628891_b78f842f67_b.jpg)
