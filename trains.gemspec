# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trains/version'

Gem::Specification.new do |spec|
  spec.name          = "trains"
  spec.version       = Trains::VERSION
  spec.authors       = ["Gregor Melhorn"]
  spec.email         = ["gregor.melhorn@gmail.com"]

  spec.summary       = %q{Thoughtworks trains technical assignment.}
  spec.description   = %q{Thoughtworks trains technical assignment.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["trains"]
  spec.require_paths = ["lib"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
