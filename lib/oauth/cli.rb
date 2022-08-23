# frozen_string_literal: true

# third party gems
require "version_gem"

require_relative "cli/version"

module OAuth
  module CLI
    class Error < StandardError; end
    # Your code goes here...
  end
end

OAuth::CLI::Version.class_eval do
  extend VersionGem::Basic
end