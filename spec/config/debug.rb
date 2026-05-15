load_debugger = ENV.fetch("DEBUG", "false").casecmp("true").zero?

require "debug" if load_debugger
