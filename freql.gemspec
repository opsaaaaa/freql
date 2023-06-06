# frozen_string_literal: true

require_relative "lib/freql/version"

Gem::Specification.new do |spec|
  spec.name = "freql"
  spec.version = Freql::VERSION
  spec.authors = ["opsaaaaa"]
  spec.email = ["sean@ferney.org"]

  spec.summary = "A library for handling word/token freqencies units."

  spec.description = "Right now all we do is convert fpmw to zipf and other units."
  spec.homepage = "https://github.com/opsaaaaa/freql"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/opsaaaaa/freql/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'msgpack', '~> 1.5', '>= 1.5.1'

end
