module Pakunok
  class Railtie < Rails::Railtie
    initializer 'pakunok.initialize' do
      ActiveSupport.on_load(:action_view) do
        include ::Pakunok::Helpers::AssetsHelper
      end
    end
  end
end
