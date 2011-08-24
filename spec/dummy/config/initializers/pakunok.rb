require 'pakunok'

Pakunok::Pakunok.current.configure do
  javascript_loader(:script)
  asset('pages.js').needs('application.js').embed
end
