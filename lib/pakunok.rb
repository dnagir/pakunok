module Pakunok
  class Engine < Rails::Engine
    initializer "pakunok.configure_rails_initialization" do |app|
      assets = app.config.assets
      if assets and assets.enabled
        require 'pakunok/haml_js_template'
        #require 'tilt'
        #Tilt.register ::Pakunok::HamlJsTemplate, 'hamljs'

        # TODO: How to register the template for sprockets???
        assets.register_engine '.hamljs', ::Pakunok::HamlJsTemplate
        #Sprockets.register_engine '.hamljs', ::Pakunok::HamlJsTemplate
      end
    end
  end
end
