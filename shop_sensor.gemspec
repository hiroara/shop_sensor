# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shop_sensor/version'

Gem::Specification.new do |spec|
  spec.name          = "shop_sensor"
  spec.version       = ShopSensor::VERSION
  spec.authors       = ["Arai Hiroki"]
  spec.email         = ["hiroara62@gmail.com"]
  spec.summary       = %q{Client library of ShopSense API}
  spec.description   = %q{This is a client library of ShopSense API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry-byebug'

  spec.add_dependency 'faraday'
end
