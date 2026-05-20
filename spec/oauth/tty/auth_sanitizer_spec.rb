# frozen_string_literal: true

RSpec.describe OAuth::TTY::AUTH_SANITIZER do
  it "keeps auth-sanitizer constants isolated inside the OAuth::TTY namespace" do
    expect(Object.const_defined?(:Auth, false)).to be(false)
    expect(Object.const_defined?(:AuthSanitizer, false)).to be(false)
  end

  it "provides filtered attributes for OAuth::TTY commands" do
    expect(OAuth::TTY::Command.ancestors).to include(described_class::FilteredAttributes)
  end
end
