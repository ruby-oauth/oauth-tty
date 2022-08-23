# frozen_string_literal: true

# For initial release as a standalone gem oauth must be an undeclared dependency.
# It will move to a declared dependency in a subsequent release.
require "oauth"

# This file is a loader hook for bundler
require "oauth/cli"
