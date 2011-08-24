module Pakunok
  module Helpers  
    module AssetsHelper
    
      def pakunok_assets
        ::Pakunok::Pakunok.current
      end
    
      def include_javascripts(path=nil)
        include_pakunok_assets :javascript, path
      end
      
      def include_stylesheets(path=nil)
        include_pakunok_assets :stylesheet, path
      end
      
      
      def include_pakunok_assets(asset_type, path=nil)
        path = (path || request.params[:controller]).to_s
        p = pakunok_assets
        renderer = p.renderer_for(p.render_types.fetch asset_type)
        renderer.render(path).html_safe
      end
      
    end             
  end
end
