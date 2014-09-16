# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ABCLogger/version'

Gem::Specification.new do |spec|
  spec.name          = "ABCLogger"
  spec.version       = ABCVersion::VERSION
  spec.authors       = ["Keith"]
  spec.email         = ["keithk23@gmail.com"]
  spec.summary       = %q{Ruby class for logging to a logfile.}
  spec.description   = %q{Ruby class for logging to stdout, stderr, or a file.}
  spec.homepage      = ''
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
