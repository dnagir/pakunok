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
        p = pakunok_assets
        path = path || (
          request.params[:controller] + {:javascript => '.js', :stylesheet => '.css'}[asset_type]
        ).to_s

        @pakunok_context ||= ::Pakunok::HttpContext.new(request)
        renderer = p.renderer_for(p.render_types.fetch asset_type)
        renderer.render(@pakunok_context, path).html_safe
      end
      
    end             
  end
end
