# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scouter/base/version'

Gem::Specification.new do |spec|
  spec.name          = 'scouter'
  spec.version       = Scouter::VERSION
  spec.authors       = ['morizyun']
  spec.email         = ['merii.ken@gmail.com']
  spec.summary       = %q{get share count in Buffer/Facebook/Feedly/GooglePlus/HatenaBookmark/Linkedin/Pinterest/Pocket/Twitter}
  spec.description   = %q{get share count in Buffer/Facebook/Feedly/GooglePlus/HatenaBookmark/Linkedin/Pinterest/Pocket/Twitter}
  spec.homepage      = 'https://github.com/morizyun/scouter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency 'hashie'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'fakeweb'
  spec.add_development_dependency 'rspec'
end
