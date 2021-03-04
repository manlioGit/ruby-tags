Gem::Specification.new do |spec|
  spec.name          = "ruby-tags"
  spec.version       = "0.1.0"
  spec.authors       = ["manlioGit"]
  spec.email         = ["manliomodugno@gmail.com"]

  spec.summary       = "RubyTags is a small XML/HTML construction templating library for Ruby, inspired by JavaTags."
  spec.homepage      = "https://github.com/manlioGit/ruby-tags"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = ["Rakefile"] + Dir["lib/**/*.rb"]
  spec.require_paths = ["lib"]
end
