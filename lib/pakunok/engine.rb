module Pakunok
  class Engine < Rails::Engine
    initializer "pakunok.configure_rails_initialization" do |app|
      next unless app.config.assets.enabled

      require 'sprockets'
      require 'sprockets/engines'
      require 'pakunok/haml_js_template'
      app.assets.register_engine '.hamljs', ::Pakunok::HamlJsTemplate
    end
  end
end
