lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twiruby/version'

Gem::Specification.new do |spec|
  spec.name          = "twiruby"
  spec.version       = TwiRuby::VERSION
  spec.authors       = ["Gomasy"]
  spec.email         = ["nyan@gomasy.jp"]
  spec.summary       = %q{Twitter library for Ruby.}
  spec.description   = %q{Twitter library for Ruby.}
  spec.homepage      = "https://github.com/Gomasy/twiruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "codeclimate-test-reporter"
end
