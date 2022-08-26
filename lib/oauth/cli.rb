# frozen_string_literal: true

module OAuth
  # Backwards compatibility hack.
  # TODO: Remove with April 2023 release of 2.0 release of oauth gem
  CLI = OAuth::TTY::CLI
end
