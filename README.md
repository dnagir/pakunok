# Pakunok - common assets that you need for Rails 3.1

_Pakunok_ contains a set of prepackaged assets that you can easily include into your Rails 3.1 application (using assets pipeline).

The list of the assets included (you can reference then using the name below prefixed with `pakunok/`:

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

You can reference the assets as usually using the sprockets.
Let's see full example (includes everything for the sake of demo):



## JavaScript Only libraries

You can simply reference plain JS libraries that do not require other assets (CSS, images) like this:

```javascript
// app/assets/javascripts/application.js

// Include latest jQuery
//= require 'pakunok/jquery'

// Or an older version
//= require 'pakunok/jquery/jquery-1.5.2'

//= require 'pakunok/innershiv'

// jQuery plug-ins do no automatically include jQuery to allow to use them as a separate script tag
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
This means that ALL of the assets will be compiled (although you only use part of it).

Please run `RAILS_ENV=production bundle exec rake assets:clean assets:precompile && tree public/assets` to verify necessary assets.

It is recommended to change the default behaviour so that you know which assets are compiled:

```ruby
# config/application.rb

# Something like this is the default
#config.assets.precompile = [/\w+\.(?!js|css).+/, /application.(css|js)$/]

# Recommended: Explicitly add assets that you use (colorpicker),
#  so that images and styles are available.
config.assets.precompile = [/application.(css|js)$/, /pakunok\/colorpicker/]

# Specify precompilable assets explicitly if you don't reference any assets from pakunok
config.assets.precompile = [/application.(css|js)$/, 'expclicit-file.js', 'pakunok/colorpicker']

# Exclude all pakunok assets from precompilation (it's ok if you reference only JS)
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


# Development

- Source hosted at [GitHub](https://github.com/dnagir/pakunok)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/pakunok/issues)

Pull requests are very welcome! But please write the specs.
