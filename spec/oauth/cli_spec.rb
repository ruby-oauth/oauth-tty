# frozen_string_literal: true

require "oauth/cli"

RSpec.describe OAuth::CLI do
  it "aliases OAuth::CLI to OAuth::TTY::CLI" do
    expect(described_class).to be(OAuth::TTY::CLI)
  end
end
