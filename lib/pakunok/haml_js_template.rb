require 'tilt/template'

module Pakunok
  class HamlJsTemplate < Tilt::Template
    self.default_mime_type = 'application/javascript'

    def prepare
      # be lazy
      require 'execjs'
    end

    def evaluate(scope, locals, &block)
      @output ||= <<-TEMPLATE
(function(scope){
  (scope.Templates || (scope.Templates = {}))['#{client_name}'] = #{compile_to_function};
})(this);
        TEMPLATE
    end

    def client_name
      #TODO: Do something better for generating name of the template
      prefix = '/assets/'
      path = eval_file
      name_start = path.rindex(prefix)
      path = file[(name_start + prefix.length)..-1] if name_start

      parts = path.split(/-|_/)
      res = parts[0] + (parts[1..-1] || []).map {|w| w.capitalize }.join
      res = res.gsub(/\/|\\/, '_')
      res.split('.').first # chomp of the extensions
    end

    def compile_to_function
      function = ExecJS.
        compile(self.class.haml_source).
        eval "Haml('#{js_string data}', {escapeHtmlByDefault: true, customEscape: #{js_custom_escape}}).toString()"
      # make sure function is annonymous
      function.sub /function \w+/, "function "
    end

    def js_string str
      (str || '').
        gsub("'")  {|m| "\\'" }.
        gsub("\n") {|m| "\\n" }
    end

    def js_custom_escape
      self.class.custom_escape ? "'#{js_string self.class.custom_escape}'" : 'null'
    end

    class << self
      attr_accessor :custom_escape

      def haml_source
        # Haml source is an asset
        @haml_source ||= IO.read File.expand_path('../../../vendor/assets/javascripts/pakunok/haml.js', __FILE__) 
      end
    end
  end
end

