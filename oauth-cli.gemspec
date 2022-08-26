# frozen_string_literal: true

require_relative "lib/oauth/tty/version"

Gem::Specification.new do |spec|
  spec.add_dependency("version_gem", "~> 1.1")

  spec.name = "oauth-tty"
  spec.version = OAuth::TTY::Version::VERSION
  spec.authors = ["James Pinto", "Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "OAuth 1.0 TTY CLI"
  spec.description = "OAuth 1.0 TTY Command Line Interface"
  spec.homepage = "https://gitlab.com/pboling/oauth-commands"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/-/tree/v#{spec.version}"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/-/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/-/issues"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "#{spec.homepage}/-/wikis/home"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("lib/**/*.rb") + ["LICENSE.txt", "README.md", "CHANGELOG.md", "CODE_OF_CONDUCT.md",
                                          "SECURITY.md", "CONTRIBUTING.md", "exe/oauth"]

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("em-http-request", "~> 1.1.7")
  spec.add_development_dependency("iconv")
  spec.add_development_dependency("minitest", "~> 5.15.0")
  spec.add_development_dependency("mocha")
  spec.add_development_dependency("rack", "~> 2.0")
  spec.add_development_dependency("rack-test")
  spec.add_development_dependency("rake", "~> 13.0")
  spec.add_development_dependency("rest-client")
  spec.add_development_dependency("rubocop-lts", "~> 18.0")
  spec.add_development_dependency("typhoeus", ">= 0.1.13")
  spec.add_development_dependency("webmock", "<= 3.19.0")
end
