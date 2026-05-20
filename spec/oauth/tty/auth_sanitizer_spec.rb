# frozen_string_literal: true

RSpec.describe "OAuth::TTY::AUTH_SANITIZER" do
  it "provides filtered attributes for OAuth::TTY commands" do
    expect(OAuth::TTY::Command.ancestors).to include(OAuth::TTY::AUTH_SANITIZER::FilteredAttributes)
  end
end
