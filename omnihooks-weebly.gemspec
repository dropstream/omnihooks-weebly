# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omnihooks-weebly/version'

Gem::Specification.new do |spec|
  spec.name          = "omnihooks-weebly"
  spec.version       = Omnihooks::Weebly::VERSION
  spec.authors       = ["Karl Falconer"]
  spec.email         = ["karl@getdropstream.com"]
  spec.summary       = %q{OmniHooks strategy for Weebly}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omnihooks', '~> 0.0.2'
  spec.add_dependency 'multi_json', '~> 1.11.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.3.0'
end
