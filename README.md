# Pakunok - common assets that you need for Rails 3.1

_Pakunok_ contains a set of prepackaged assets that you can easily include into your Rails 3.1 application (using assets pipeline).

The list of the assets included (reference those prefixed with `pakunok/`):

- haml (also includes Rails 3.1 precompilation, see below)
- jquery (defaults to 1.6.2)
  - jquery/jquery-1.6.2
  - jquery/jquery-1.5.2
- jquery.validate
- colorpicker (has CSS)
- fileuploader (has CSS)
- innershiv
- jquery.form
- jquery.validate
- jquery.jscrollpane (has CSS)
- jquery.mousewheel (optional improvement for jquery.jscrollpane)
- mwheelIntent  (optional improvement for jquery.jscrollpane)
- jquery.viewport
- jquery-ui - standalone files (`jquery-ui/`): no dependencies tracked, serve these when part of jQueryUI has already been included elsewhere
  - accordion
  - autocomplete
  - button
  - core
  - datepicker
  - dialog
  - draggable
  - droppable
  - effects (all effects, does not require jQuery-UI core)
  - mouse
  - position
  - progressbar
  - resizable
  - selectable
  - slider
  - sortable
  - tabs
  - widget
- jquery-ui -  combined (`jquery-ui/pack/`): ready-to-go options, you can include multiple into only one script file
  - accordion
  - autocomplete
  - basic (includes core, widget, position, mouse components)
  - button
  - datepicker
  - dialog
  - draggable
  - droppable
  - effects (same as standalone)
  - progressbar
  - resizable
  - selectable
  - slider
  - sortable
  - tabs


Tested on MRI Ruby 1.9.2.

If you have any questions please contact me [@dnagir](http://www.ApproachE.com).


# Install

Add it to your Rails application's `Gemfile`:

```ruby
gem 'pakunok'
```

Then `bundle install`.

# Usage

Reference as you normally do with Sprockets.
Let's see some examples:


## JavaScript-only libraries

You can simply reference plain JS libraries that do not require other assets (CSS, images) like this:

```javascript
// app/assets/javascripts/application.js

// Include latest jQuery
//= require 'pakunok/jquery'

// Or an older version
//= require 'pakunok/jquery/jquery-1.5.2'

//= require 'pakunok/innershiv'

// jQuery plug-ins do no depend on jQuery to allow using as a separate HTTP resource
//= require 'pakunok/jquery.form'
//= require 'pakunok/jquery.jscrollpane'
//= require 'pakunok/jquery.mousewheel'
//= require 'pakunok/mwheelIntent'

//= require 'pakunok/jquery.validate'
//= require 'pakunok/jquery.validate/additional-methods'

//= require 'pakunok/jquery.viewport'
```

It is also possible to reference the assets directly from the views.

## Libraries with related resources

If the library has a related CSS file, then it can be included into your CSS (or served as a separate file).
It is named after the JavaScript library.

```css
/*
 * app/assets/stylesheets/application.css
 *= require 'pakunok/colorpicker'
 *= require 'pakunok/fileuploader'
 *= require 'pakunok/jquery.jscrollpane' 
*/
```


# Precompilation
By default Rails precompiles all the assets of all included libraries.
This means that _ALL_ of the assets will be compiled (although you rarely need that).

Please run `RAILS_ENV=production bundle exec rake assets:clean assets:precompile && tree public/assets` to verify necessary files.

It is recommended to change the default behaviour so that you are not precompiling assets that the application will never use:

```ruby
# config/application.rb

# Something like this is the Rails default
#config.assets.precompile = [/\w+\.(?!js|css).+/, /application.(css|js)$/]

# Recommended: Explicitly add assets that you use (colorpicker),
#  so that images and styles are available.
config.assets.precompile = [/application.(css|js)$/, /pakunok\/colorpicker/]

# Exclude all pakunok assets from precompilation (it's ok if you don't have direct HTTP request to them)
config.assets.precompile = [/(!pakunok)\w+\.(?!js|css).+/, /application.(css|js)$/]

# Exclude all pakunok assets, but explicitly add ones that you use (colorpicker),
#  so that images and styles are available.
config.assets.precompile = [/(!pakunok)\w+\.(?!js|css).+/, /application.(css|js)$/, /pakunok\/colorpicker/]
```

# Note on JQuery-UI

In many cases you do not need the full jQuery-UI package, so you can do the following:

1. Bundle pre-packed jQuery UI components that you are going to use on all pages into `application.js` (eg: `require 'pakunok/jquery-ui/pack/dialog'`).
2. Serve the other additional components when you need them (as `require 'pakunok/jquery-ui/effects'`).

All the files under `pakunok/jquery-ui/*` do not automatically include depndencies. This means that you can serve them separately.
But if you want to include all the dependencies into a single file, then use `pakunok/jquery-ui/pack/*`.


# HAML for client side templating
_Pakunok_ provides a new templating engine for Rails 3.1 that can be used to produce JavsScript templates.

What you need to do is to use `.hamljs` extension on a javascript file with the HAML content.
It will generate a plain optimised JavaScipt function that you can use on the client.

For example, assuming you have a file `app/assets/javascripts/comment.js.hamljs` with the content:

```haml
.comment
  .text= text
  .author= author  
```

Then you can `require comment` from the `application.js`.
This gives you access to `JST.comment` function allowing you to write JavaScript like:

```javascript
var html = JST.comment({author: 'Dima', text: 'Awesome'});
$("#commit").append(html)
```

*NOTE*: [HAML-JS](https://github.com/creationix/haml-js) is a little bit different from the original HAML for Ruby.

In case _pakunok_ could magically provide a good name for your template function, you can access it as `JST['what ever it is!']`.
The name of the template function is derrived from the file name. Some examples for you:

```
  file                      => file
  file.js.erb.hamljs        => file
  file-with-dash.hamljs     => fileWithDash
  file_with_underscore      => fileWithUnderscore
  dir/foo_bar               => dir_fooBar
  win\dir\foo_bar           => win_dir_fooBar
  d1/d2/foo_bar.js.a.b.c.d  => d1_d2_fooBar
```

Yes, it uses one global variable `JST` to add all the functions but you can change it (see example further).

_Pakunok_ will escape the HTML using simple built-in function.
The escaping function is generated inside each template resulting in larger JavaScript code base.
It is *highly* recommended to set it to your own when you have more than a couple of templates.


## HAML Configuration options

```ruby
# Somewhere in your app...
require 'pakunok/haml_js_template'

# Change the escapeHTML function
Pakunok::HamlJsTemplate.custom_escape = 'YourApp.html_escape' # default is nil - built-in

# Change the global variable to attach templates to
Pakunok::HamlJsTemplate.root_variable = 'Templates'  # default is 'JST'
```



# Development

- Source hosted at [GitHub](https://github.com/dnagir/pakunok)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/pakunok/issues)

Pull requests are very welcome! But please write the specs.

To start, clone the repo and then:

```shell
bundle install
bundle exec rspec spec/
```
