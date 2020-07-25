# Mystax

[Mustache](https://en.wikipedia.org/wiki/Mustache_(template_system)) is a [web template system](https://en.wikipedia.org/wiki/Web_template_system), which use heavily braces `{ }`, hence its name.

Mystax support basic features of mustache templating.

## Usage

Create a parser for one template (`Text` variable) and compile it (only one time).

```4d
$parser:=mystax.parse($template) // with $template a Text variable, which contains your template.
````

Then render the result by passing the data you want to inject as `Object`.

For instance with this simple template:

```Handlebars
Hello {{world}}
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

Using a `Collection` of object or an entity selection you could repeat a section

For instance if a book have multiple authors:
```Handlebars
<h1>{{title}}</h1>
{{#author}}
  <h2>By {{name}}</h2>
{{/author}}
```

You can pass the list of authors as collection/selection

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

## TODO

- support more features and fix some bugs [see test](Specs)

## Why Mystax

[Myxtax](https://en.wiktionary.org/wiki/mystax) word means mustache and it used to name some species

- [Ellopostoma_mystax](https://en.wikipedia.org/wiki/Ellopostoma_mystax)
- [Thryssa mystax](https://en.wikipedia.org/wiki/Thryssa_mystax)
- [Saguinus mystax](https://en.wikipedia.org/wiki/Moustached_tamarin)
- [Gnathophis mystax](https://en.wikipedia.org/wiki/Thinlip_conger)
- [Mammillaria mystax](https://en.wikipedia.org/wiki/Mammillaria_mystax)

### Saguinus mystax

![Saguinus mystax](https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Saguinus_mystax_at_the_Bronx_Zoo_01.jpg/440px-Saguinus_mystax_at_the_Bronx_Zoo_01.jpg)
