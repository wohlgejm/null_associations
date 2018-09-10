# rubocop:disable Style/StringLiterals
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "null_associations/version"

Gem::Specification.new do |spec|
  spec.name          = "null_associations"
  spec.version       = NullAssociations::VERSION
  spec.authors       = ["wohlgejm"]
  spec.email         = ["wohlgejm@gmail.com"]

  spec.summary       = "Null belongs_to and has_one associations for Rails."
  spec.description   = "Return null objects for your Rails belongs_to and has_one associations"
  spec.homepage      = "https://github.com/wohlgejm/null_associations"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord", "~> 4.2"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sqlite3"
end
# rubocop:enable Style/StringLiterals
