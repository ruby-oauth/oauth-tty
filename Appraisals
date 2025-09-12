# frozen_string_literal: true

# HOW TO UPDATE APPRAISALS (will run rubocop_gradual's autocorrect afterward):
#   bin/rake appraisals:update

# Lock/Unlock Deps Pattern
#
# Two often conflicting goals resolved!
#
#  - unlocked_deps.yml
#    - All runtime & dev dependencies, but does not have a `gemfiles/*.gemfile.lock` committed
#    - Uses an Appraisal2 "unlocked_deps" gemfile, and the current MRI Ruby release
#    - Know when new dependency releases will break local dev with unlocked dependencies
#    - Broken workflow indicates that new releases of dependencies may not work
#
#  - locked_deps.yml
#    - All runtime & dev dependencies, and has a `Gemfile.lock` committed
#    - Uses the project's main Gemfile, and the current MRI Ruby release
#    - Matches what contributors and maintainers use locally for development
#    - Broken workflow indicates that a new contributor will have a bad time
#
appraise "unlocked_deps" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/documentation.gemfile"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Used for head (nightly) releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "head" do
  gem "oauth", ">= 1.1.0"
  gem "benchmark", "~> 0.4", ">= 0.4.1"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Used for current releases of ruby, truffleruby, and jruby.
# Split into discrete appraisals if one of them needs a dependency locked discretely.
appraise "current" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Test current Rubies against head versions of runtime dependencies
appraise "dep-heads" do
  gem "oauth", github: "ruby-oauth/oauth", branch: "main"
  eval_gemfile "modular/runtime_heads.gemfile"
end

appraise "ruby-2-3" do
  gem "oauth", github: "ruby-oauth/oauth", branch: "main"
  # gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r2.3/libs.gemfile"
end

appraise "ruby-2-4" do
  gem "oauth", github: "ruby-oauth/oauth", branch: "main"
  # gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r2.4/libs.gemfile"
end

appraise "ruby-2-5" do
  gem "oauth", github: "ruby-oauth/oauth", branch: "main"
  # gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

appraise "ruby-2-6" do
  gem "oauth", github: "ruby-oauth/oauth", branch: "main"
  # gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r2.6/libs.gemfile"
end

appraise "ruby-2-7" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r2/libs.gemfile"
end

appraise "ruby-3-0" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

appraise "ruby-3-1" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r3.1/libs.gemfile"
end

appraise "ruby-3-2" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

appraise "ruby-3-3" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs/r3/libs.gemfile"
end

# Only run security audit on the latest version of Ruby
appraise "audit" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Only run coverage on the latest version of Ruby
appraise "coverage" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/coverage.gemfile"
  eval_gemfile "modular/optional.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end

# Only run linter on the latest version of Ruby (but, in support of oldest supported Ruby version)
appraise "style" do
  gem "oauth", ">= 1.1.0"
  eval_gemfile "modular/style.gemfile"
  eval_gemfile "modular/x_std_libs.gemfile"
end
