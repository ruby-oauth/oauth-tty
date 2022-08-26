# frozen_string_literal: true

# This file is a loader hook for bundler
require "oauth/tty"

# A gem was released in 2011 which was a rudimentary commands for the oauth gem,
#   thus it occupies the name in RubyGems.org.
# This library was originally written as part of the oauth gem, in 2016, as OAuth::CLI.
# This gem is named oauth-tty, but intends to have backwards compatibility with oauth gem v1.0.x.
# Now that it is being extracted there is a name conflict.
#
# oauth-cli is a backwards compatibility loader hook for bundler
# TODO: Remove with April 2023 release of 2.0 release of oauth gem
require "oauth_cli"
