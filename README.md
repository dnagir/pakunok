# Pakunok - all common assets that you need for Rails 3.1

Pakunok contains a set of prepackaged assets so that you can easily include those into you Rails 3.1 application with assets pipeline.

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


# Install

Install the gem:

Add it to your `Gemfile`:

```ruby
gem 'pakunok'
```


# Usage

You can reference the assets as usually using the sprockets.
Let's see full example (includes everything for the sake of demo):



## JavaScript Only libraries

You can simply reference plan JS libraries that do not require other assets (CSS, images) like this:

```javascript
// app/assets/javascripts/application.js

// Include latest jQuery
//= require 'pakunok/jquery'

// Or an older version
//= require 'pakunok/jquery/jquery-1.5.2'

//= require 'pakunok/innershiv'

//= require 'pakunok/innershiv'
//= require 'pakunok/jquery.form'

// jQuery plug-ins do no automatically include jQuery to allow to use them as a separate script tag
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


# Note on JQuery-UI

In many cases you do not need the full jQuery-UI package, so you can do the following:

1. Bundle pre-packed jQuery UI components that you are going to use on all pages into `application.js` (eg: `require 'pakunok/jquery-ui/pack/dialog'`).
2. Serve the other additional components when you need them (as `require 'pakunok/jquery-ui/effects'`).

All the files under `pakunok/jquery-ui/*` do not automatically include depndencies. This means that you can serve them separately.
But if you want to include all the dependencies into a single file, then use `pakunok/jquery-ui/pack/*`.


## Development

- Source hosted at [GitHub](https://github.com/dnagir/pakunok)
- Report issues and feature requests to [GitHub Issues](https://github.com/dnagir/pakunok/issues)

Pull requests are very welcome! But please write the specs.
