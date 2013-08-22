# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-stitch-plus/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-stitch-plus"
  spec.version       = Jekyll::StitchPlusVersion::VERSION
  spec.authors       = ["Brandon Mathis"]
  spec.email         = ["brandon@imathis.com"]
  spec.description   = %q{A Jekyll plugin for compiling javascripts with Stitch Plus}
  spec.summary       = %q{A Jekyll plugin for compiling javascripts with Stitch Plus}
  spec.homepage      = "https://github.com/octopress/jekyll-stitch-plus"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "stitch-plus", "~> 1.0.9"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
