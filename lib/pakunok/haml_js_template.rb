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
  (scope.Templates || (scope.Templates = {}))['#{client_name}'] = #{compile_to_function}
})(this);
        TEMPLATE
    end

    def client_name
      name
    end

    def compile_to_function
      function = ExecJS.compile(self.class.haml_source).eval("Haml('#{escaped_haml_data}').toString()")
      # make sure function is annonymous
      function.sub /function \w+/, "function "
    end

    def escaped_haml_data
      escaped = (data || '')
        .gsub("'")  {|m| "\\'" }
        .gsub("\n") {|m| "\\n" }
    end

    def self.haml_source
      # Haml source is an asset
      @haml_source ||= IO.read File.expand_path('../../../vendor/assets/javascripts/pakunok/haml.js', __FILE__) 
    end
  end
end

