# frozen_string_literal: true

# stdlib
require "optparse"

# third party gems
require "version_gem"

# For initial release as a standalone gem, this gem must not declare oauth as a dependency,
#   because it *is* a dependency of oauth v1.1, and that would create a circular dependency.
# It will move to a declared dependency in a subsequent release.
require "oauth"

# this gem
require_relative "tty/version"
require_relative "tty/cli"
require_relative "tty/command"
require_relative "tty/commands/help_command"
require_relative "tty/commands/query_command"
require_relative "tty/commands/authorize_command"
require_relative "tty/commands/sign_command"
require_relative "tty/commands/version_command"

# A gem was released in 2011 which was a rudimentary commands for the oauth gem,
#   thus it occupies the name in RubyGems.org.
# This library was originally written as part of the oauth gem, in 2016, as OAuth::TTY.
# This gem is named oauth-tty, but intends to have backwards compatibility with oauth gem v1.0.x.
# Now that it is being extracted there is a name conflict.
#
# oauth-cli is a backwards compatibility loader hook for bundler
# TODO: Remove with April 2023 release of 2.0 release of oauth gem
require "oauth/cli"

module OAuth
  # The namespace of this gem
  module TTY
  end
end

OAuth::TTY::Version.class_eval do
  extend VersionGem::Basic
end
