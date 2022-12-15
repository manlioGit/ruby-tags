# Ruby::Tags

RubyTags is a small XML/HTML construction templating library for Ruby, inspired by [JavaTags](https://github.com/manlioGit/javatags).

It can renders fragments like:

```ruby
html5(attr(lang: "en"),
  head(
    meta(attr('http-equiv': "Content-Type", content: "text/html; charset=UTF-8")),
    title(text("title")),
    link(attr(href: "xxx.css", rel: "stylesheet"))
  )
).render
```

in html:

```html
<!DOCTYPE html>
<html lang='en'>
  <head>
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
    <title>title</title>
    <link href='xxx.css' rel='stylesheet'/>
 </head>
</html>
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-tags'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ruby-tags

## Online converter

~~To convert html to Ruby-Tags format try [online converter](http://javatagsconverter.herokuapp.com).~~
Given heroku plan changes, follow docker instruction reported [here](https://github.com/manlioGit/javatagsconverter#local-run)

## Usage

Include module `Html` in your class.

```ruby
class Layout
  include Ruby::Tags::Html
  
  #...
end
```
### Attributes:

You have different ways to use attributes.

#### Declarative

Using Ruby#Hash definition, i.e. `name: "value"`, `:name => "value"` in `attr` method. 

```ruby
attr(class: "navbar", style: "border: 0;")
```

#### Dynamic

An attribute can be built fluently with `add` method, using key-value or `Attribute` overload

```ruby
attr()
  .add(class: "fa fa-up", xxx: "show")
  .add(style: "border: 0;")
	
attr()
  .add(attr(class: "navbar"))
  .add(attr(style: "border: 0;")

```

`add method` appends values if already defined for an attribute

```ruby
attr(class: "navbar")
  .add(class: "fa fa-up")
  .add(style: "border: 0;")
```

renders

```html
 class='navbar fa fa-up' style='border: 0;'
```

An attribute can be modified with remove method, using key-value, Attribute overload or key

```ruby
attr(class: ".some fa fa-up", xxx: "fa fa-up")
  .remove(class: "fa-up")
  .remove(xxx: "fa")
  .remove(xxx: "fa-up")
```

renders

```html
class='.some fa'
```

```ruby
attr(class: ".some fa fa-up", xxx: "fa fa-up").remove(:class)
```

renders

```html
xxx='fa fa-up'
```

see [unit tests](https://github.com/manlioGit/ruby-tags/blob/master/test/ruby/attribute_test.rb) for other examples

### Layouts:

An example of page layout:

```ruby
class Layout
  include Ruby::Tags::Html

  def initialize(title, body)
    @title = title
    @body = body
  end
  
  def render
    html5(
      head(
        meta(attr(charset: "utf-8")),
        meta(attr('http-equiv': "X-UA-Compatible", content: "IE=edge")),
        meta(attr(name: "viewport", content: "width=device-width, initial-scale=1")),
        title(text(@title)),
        link(attr(rel: "stylesheet", href: "/css/bootstrap.min.css")),
        link(attr(rel: "stylesheet", href: "/css/app.css"))
      ),
      body(
        @body,
        script(attr(src: "/js/jquery.min.js")),
        script(attr(src: "/js/bootstrap.min.js"))
      )
    ).render
  end
end
```

An example of table using reduce:

```ruby
data = [{ th1: "value1", th2: "value2" }, { th1: "value3", th2: "value4" }]
header = data.first.keys

table(attr(class: "table"),
  thead(
    header.reduce(tr) { |tr, header| tr.add(th(text(header.to_s))) },
  ),
  data.reduce(tbody) do |tbody, record|
    tbody.add(
      header.reduce(tr) { |row, key| row.add(td(text(record[key]))) }
    )
  end
)
```

#### Element

Ruby-Tags defines Text, Void, NonVoid and Group elements (see [W3C Recommendation](https://www.w3.org/TR/html/syntax.html#writing-html-documents-elements)).

Every tag method (e.g. html5, body and so on) is defined as method using a Void or NonVoid element in accordance with [W3C Recommendation](https://www.w3.org/TR/html).

To render text use `text` method.

```ruby
text("aaa")
```

To render list of Elements use `group` method.

```ruby
...
list = %w(a b c).map { |x| li(text(x)) }
ul(
  group(*list)
)
...

```

You can also use `add` method to add children/sibling to a NonVoid/Void element respectively, for example:

```ruby
...
g = group()
%w(a b c).each { |x| g.add(li(text(x))) }
...
	
ul = ul()
%w(a b c).each { |x| ul.add(li(text(x))) }

```
Or in a builder/fluent syntax way:

```ruby
ul()
  .add(li(text("item 1")))
  .add(li(text("item 2")))
  .add(li(text("item 3")))	
  
div(attr(class: "xxx"))
  .add(span(text("content")))
  .add(p(text("other content")))
```

Elements are equal ignoring attribute order definition, for example:

```ruby
def test_equality
  div1 = NonVoid.new("div", Attribute.new(a: "b", c: "d"))
  div2 = NonVoid.new("div", Attribute.new(c: "d", a: "b"))

  assert_equal div1, div2
end
```

see [unit tests](https://github.com/manlioGit/ruby-tags/tree/master/test/ruby) for other examples

## Development

After checking out the repo, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/manlioGit/ruby-tags.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
