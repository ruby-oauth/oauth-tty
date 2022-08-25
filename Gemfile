# frozen_string_literal: true

source "https://rubygems.org"

gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

# Curb has trouble building native extentions on Windows platform
curb = !Gem.win_platform?

ruby "3.1.2"

gem "oauth"
gem "actionpack", [">= 6", "<= 8"]

gem "pry", platforms: %i[mri]
platforms :mri do
  gem "codecov", "~> 0.6" # For CodeCov
  gem "overcommit", "~> 0.58"
  gem "rubocop-md"
  gem "rubocop-minitest"
  gem "rubocop-packaging"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-thread_safety"
  gem "simplecov", "~> 0.21", require: false
  gem "simplecov-cobertura" # XML for Jenkins
  gem "simplecov-json" # For CodeClimate
  gem "simplecov-lcov", "~> 0.8", require: false

  # Add `byebug` to your code where you want to drop to REPL, and add DEBUG=true when running tests
  gem "byebug"
  # WebMock is known to work with Curb >= 0.7.16, < 1.1, except versions 0.8.7
  gem "curb", [">= 0.7.16", "< 1.1", "!= 0.8.7"] if curb
  gem "pry-byebug"
end

### deps for documentation and rdoc.info
group :documentation do
  gem "github-markup", platform: :mri
  gem "redcarpet", platform: :mri
  gem "yard", require: false
end

# Test gems
group :test do
  gem "mocha"
  gem "minitest", "~> 5.15.0"
  gem "rack", "~> 2.0"
  gem "rack-test"
  gem "rest-client"
  gem "typhoeus", ">= 0.1.13"
  gem "webmock", "<= 3.19.0"
end

# Gitlab won't have "development" gems as defined in the gemspec when running CI,
# unless they are made to load here in the Gemfile.
group :ci do
  gem "em-http-request", "~> 1.1.7"
  gem "iconv"
  gem "rake", "~> 13.0"
  gem "rubocop-lts", "~> 18.0"
end
