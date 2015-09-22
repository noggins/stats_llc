# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stats_llc/version'

Gem::Specification.new do |spec|
  spec.name          = "stats_llc"
  spec.version       = StatsLLC::VERSION
  spec.authors       = ["tigershen23"]
  spec.email         = ["tigershen23@gmail.com"]

  spec.summary       = %q{Ruby wrapper for Stats, LLC API}
  spec.description       = %q{Ruby wrapper for Stats, LLC API}
  spec.homepage      = "http://tigershen.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency 'awesome_print', "~> 1.6.1"
  spec.add_development_dependency 'dotenv', "~> 2.0.2"
  spec.add_development_dependency 'pry-byebug'

  spec.add_runtime_dependency 'httparty'
end
