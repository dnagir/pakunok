class InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)  

  def install_initializer
    copy_file "pakunok.rb", "config/initializers/pakunok.rb"
  end
end  
