require 'pakunok'

Pakunok::Pakunok.current.configure do
  # You can choose how to include the assets into the page.
  # The <script> tag is used by default.
  # But can be changed to use JavaScript loader API, such as LABjs
  javascript_loader(:script) # one of [:script, :labjs]

  ## Write asset dependecies here.
  ## For example:
  # asset('jquery.js')      .replace_with :cdn => 'ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js'
  # asset('enhance.js')     .needs('jquery.js').as_async
  # asset('application.js') .needs('jquery.js')
  # asset('posts.js')       .needs('application.js')
  # asset('blog.js')        .needs('application.js')
  # asset('home.js')        .needs('jquery.js', 'analytics.js').embed
  #
  ## or if you just want to set the dependencies, you can use:
  # add_dependencies {
  #   'enhance.js'      => 'jquery.js',
  #   'application.js'  => 'jquery.js',
  #   'posts.js'        => 'application.js',
  #   'blog.js'         => 'application.js',
  #   'home.js'         => 'jquery.js'
  #   'home.js'         => 'analytics.js'
  # }
  ## then you can modify the assets that are already defined in such a way:
  # asset('enhance.js').as_async
  # asset('home.js').embed
  
  ## The options for an asset are:
  ## 
  ## .replace_with(:cdn => 'url with or without protocol')
  ##    Will replace the asset with the given url in production environment.
  ##    If the url include the protocol (https:// or http://) that it always be used.
  ##    Otherwise the same protocol as request is implied.
  ##
  ## .as_async - will try to reference the script asynchronously. That means it can't rely on order of loading.
  ##
  ## .embed - embeds the asset directly into the page. Good for small assets to save on number of HTTP requests.
end
