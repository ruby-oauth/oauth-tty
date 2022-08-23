# frozen_string_literal: true

require_relative "lib/oauth/cli/version"

Gem::Specification.new do |spec|
  spec.add_dependency("version_gem", "~> 1.1")

  spec.name = "oauth-cli"
  spec.version = OAuth::CLI::Version::VERSION
  spec.authors = ["James Pinto", "Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "OAuth 1.0 Command Line Interface"
  spec.description = "OAuth 1.0 Command Line Interface"
  spec.homepage = "https://gitlab.com/pboling/oauth-cli"
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
                                          "SECURITY.md", "CONTRIBUTING.md", "bin/oauth"]

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

  # NOTE: This would normally be a runtime dependency,
  #       but the initial release aims for complete backwards compatibility with oauth v1.0,
  #       where the cli was optional,
  #       and required the caller to have already installed undeclared dependencies such as this.
  #       When oauth v1.1 is released this will move to a runtime dependency,
  #       and oauth will no longer depend directly on this gem.
  spec.add_development_dependency("actionpack", ["<= 8", ">= 6"])
end
