# HTML Builder

A silly little HTML builder written in Ruby:

```ruby
l2.1.2 :001 > load 'html.rb'
 => true
2.1.2 :002 > HTML.html do
2.1.2 :003 >   head do
2.1.2 :004 >     title { "Hello HTML!" }
2.1.2 :005?>     meta charset: "utf-8"
2.1.2 :006?>   end
2.1.2 :007?>
2.1.2 :008 >   body do
2.1.2 :009 >     h1 { "Hello world" }
2.1.2 :010?>     p { "This is an #{em { "exciting" }} piece of software" }
2.1.2 :011?>     p { "It also has #{a(href: "https://www.google.com/") { "links" }}!"}
2.1.2 :012?>   end
2.1.2 :013?> end
 => "<html><head><title>Hello HTML!</title><meta charset=\"utf-8\" /></head><body><h1>Hello world</h1><p>This is an <em>exciting</em> piece of software</p><p>It also has <a href=\"https://www.google.com/\">links</a>!</p></body></html>"
```

## License

This code was written by David Albert and is in the public domain, but I wouldn't recommend using it for anything if I were you.
