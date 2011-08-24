require 'pakunok/railtie' if defined?(::Rails)
require 'pakunok/engine' if defined?(::Rails)

module Pakunok
  extend ActiveSupport::Autoload
  autoload :Pakunok, 'pakunok/pakunok'

  module AssetRenderers
    autoload :ScriptRenderer, 'pakunok/renderers/script_renderer'
  end
  
  module Helpers  
    autoload :AssetsHelper, 'pakunok/helpers/assets_helper'
  end
end
