# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pakunok/version"

Gem::Specification.new do |s|
  s.name        = "pakunok"
  s.version     = Pakunok::Version::VERSION
  s.authors     = ["Dmytrii Nagirniak"]
  s.email       = ["dnagir@gmail.com"]
  s.homepage    = "http://github.com/dnagir/pakunok"
  s.summary     = %q{Common assets for Rails 3.1 applications}
  s.description = %q{Pakunok has a set of prepackaged assets that you can easily include into your Rails 3.1 application (using assets pipeline).}

  s.rubyforge_project = "pakunok"

  s.add_dependency             'rails', '>= 3.1.0.rc5'
  s.add_dependency             'sprockets', '>= 2.0.0.beta13'
  s.add_dependency             'execjs'
  s.add_development_dependency 'rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
