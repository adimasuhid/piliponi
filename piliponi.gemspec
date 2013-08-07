# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'piliponi/version'

Gem::Specification.new do |spec|
  spec.name          = "piliponi"
  spec.version       = Piliponi::VERSION
  spec.authors       = ["Ace Dimasuhid"]
  spec.email         = ["ace.dimasuhid@gmail.com"]
  spec.description   = %q{Pilipino Mobile Phone Formatter}
  spec.summary       = %q{Mobile Phone Number Formatter for the Philippines}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
