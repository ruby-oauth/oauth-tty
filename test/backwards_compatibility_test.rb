# frozen_string_literal: true

require_relative "test_helper"

class BackwardsCompatibilityTest < Minitest::Test
  def test_backwards_compat
    assert_equal OAuth::CLI, OAuth::TTY::CLI
  end
end
