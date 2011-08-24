module Pakunok
  module AssetRenderers


    class ScriptRenderer
      def initialize(pakunok)
        @pakunok = pakunok
      end

      def render(context, path)
        asset = @pakunok.asset(path)
        parts = asset.full_dependencies.map do |dep|
          render_asset(context, dep)
        end + [render_asset(context, asset)]
        parts.join(separator)
      end

      def separator
        "\n    "
      end

      def render_asset(context, asset)
        async_attr = asset.async? ? " async='async'" : ''
        if asset.embedded?
          "<script type='text/javascript'#{async_attr}>\n" +
          context.rails_assets[asset.path].to_s +
          "\n</script>"
        else
          "<script type='text/javascript' src='#{asset.url(context)}'#{async_attr}></script>"
        end
      end

    end

  end
end
