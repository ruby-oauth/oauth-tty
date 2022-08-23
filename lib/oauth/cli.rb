# frozen_string_literal: true

# stdlib
require "optparse"

# third party gems
require "version_gem"
require "active_support/core_ext/string/inflections"

# this gem
require_relative "cli/version"
require_relative "cli/base_command"
require_relative "cli/help_command"
require_relative "cli/query_command"
require_relative "cli/authorize_command"
require_relative "cli/sign_command"
require_relative "cli/version_command"

module OAuth
  # TODO: The library namespace should be a module, not a class.
  class CLI
    def self.puts_red(string)
      puts "\033[0;91m#{string}\033[0m"
    end

    ALIASES = {
      "h" => "help",
      "v" => "version",
      "q" => "query",
      "a" => "authorize",
      "s" => "sign"
    }.freeze

    def initialize(stdout, stdin, stderr, command, arguments)
      klass = get_command_class(parse_command(command))
      @command = klass.new(stdout, stdin, stderr, arguments)
      @help_command = HelpCommand.new(stdout, stdin, stderr, [])
    end

    def run
      @command.run
    end

    private

    def get_command_class(command)
      Object.const_get("OAuth::CLI::#{command.camelize}Command")
    end

    def parse_command(command)
      case command = command.to_s.downcase
      when "--version", "-v"
        "version"
      when "--help", "-h", nil, ""
        "help"
      when *ALIASES.keys
        ALIASES[command]
      when *ALIASES.values
        command
      else
        OAuth::CLI.puts_red "Command '#{command}' not found"
        "help"
      end
    end
  end
end

OAuth::CLI::Version.class_eval do
  extend VersionGem::Basic
end
