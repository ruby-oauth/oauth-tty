load_debugger = ENV.fetch("DEBUG", "false").casecmp("true").zero?
puts "LOADING DEBUGGER: #{load_debugger}" if load_debugger

require "debug" if load_debugger
