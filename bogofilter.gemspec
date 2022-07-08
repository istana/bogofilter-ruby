# frozen_string_literal: true

require_relative "lib/bogofilter/version"

Gem::Specification.new do |spec|
  spec.name = "bogofilter"
  spec.version = Bogofilter::VERSION
  spec.authors = ["Ivan Stana"]
  spec.email = ["^_^@myrtana.sk"]

  spec.summary = "Ruby library for spam detection using bogofilter executable"
  spec.description = "A simple library written in Ruby language to detect spam built around bogofilter executable.
The supported input format is the same as in bogofilter - text, EML, mbox."
  spec.homepage = "https://github.com/istana/bogofilter-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.1.0"

  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/istana/bogofilter-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/istana/bogofilter-ruby/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "terrapin", "~> 0.6"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
