# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-positionly/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Piotr Chmolowski"]
  gem.email         = ["piotr@positionly.com"]
  gem.description   = %q{Omniauth plugin for Positionly API}
  gem.summary       = %q{Omniauth plugin for Positionly API}

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  gem.name          = "omniauth-positionly"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Positionly::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.1'
end
