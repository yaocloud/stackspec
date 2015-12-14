# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stackspec/version'

Gem::Specification.new do |spec|
  spec.name          = "stackspec"
  spec.version       = Stackspec::VERSION
  spec.authors       = ["Uchio KONDO"]
  spec.email         = ["udzura@udzura.jp"]

  spec.summary       = %q{A testing framework for OpenStack resource orchestration}
  spec.description   = %q{A testing framework for OpenStack resource orchestration}
  spec.homepage      = "https://github.com/udzura/stackspec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'yao'
  spec.add_runtime_dependency 'rspec', '>= 3'
  spec.add_runtime_dependency 'rspec-its'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
end
