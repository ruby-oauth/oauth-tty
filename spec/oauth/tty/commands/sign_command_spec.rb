# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::SignCommand, :check_output do
  let(:stdout) { StringIO.new }
  # Use a path relative to the project spec/ root so specs are idempotent regardless of CWD
  let(:fixture_path) { File.expand_path("../../../support/fixtures/oauth.opts", __dir__) }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  # Helper to run CLI and capture stdout string
  def run_cli(command, argv)
    cli = OAuth::TTY::CLI.new(stdout, stdin, stderr, command, argv.dup)
    cli.run
    stdout.rewind
    out = stdout.read
    stdout.truncate(0)
    stdout.rewind
    out
  end

  it "loads options from a file with -O and produces same signature as inline args (quoted values supported)" do
    require "shellwords"
    # Signature via -O file
    sig_from_file = run_cli("sign", ["-O", fixture_path])

    # Signature via equivalent inline args (tokens parsed like a shell)
    inline_args = File.readlines(fixture_path, chomp: true).flat_map { |l| Shellwords.shellsplit(l) }
    sig_inline = run_cli("sign", inline_args)

    expect(sig_from_file).to eq(sig_inline)
    # Basic sanity: looks like a base64 signature string
    expect(sig_from_file.strip).to match(/^[A-Za-z0-9+\/]+=*\n?$/)
  end

  it "allows later flags to override values loaded from the options file (later flags win)" do
    require "shellwords"
    # Compute expected signature when overriding the method to POST
    inline_args = File.readlines(fixture_path, chomp: true).flat_map { |l| Shellwords.shellsplit(l) }
    overridden_inline = inline_args.dup
    # Replace method to POST (remove any existing --method value then add POST at the end)
    # Simpler approach: just append --method POST to override prior value
    overridden_inline += ["--method", "POST"]

    expected_sig = run_cli("sign", overridden_inline)

    # Now via -O file + later CLI flags
    sig_from_file_then_override = run_cli("sign", ["-O", fixture_path, "--method", "POST"])

    expect(sig_from_file_then_override).to eq(expected_sig)
  end

  it "prints non-OAuth parameters block and a trailing blank line in verbose mode" do
    args = [
      "--consumer-key",
      "ck_123",
      "--consumer-secret",
      "cs_456",
      "--token",
      "at_789",
      "--secret",
      "ats_abc",
      "--nonce",
      "4d7b2e0f9a",
      "--timestamp",
      "1699999999",
      "--method",
      "GET",
      "--uri",
      "https://api.example.com/v1/profile",
      "--parameters",
      "foo:bar",
      "--parameters",
      "status=active",
      "--header",
      "--verbose",
    ]

    out = run_cli("sign", args)

    expect(out).to include("OAuth parameters:")
    # Ensure the non-oauth Parameters section is printed
    expect(out).to include("Parameters:")
    expect(out).to include("  foo: bar")
    expect(out).to include("  status: active")
    # Ensure there is a blank line after the non-oauth parameters block
    expect(out).to match(/Parameters:\n(?:  .*\n)+\n/)
  end

  it "in XMPP verbose mode prints stanza and note, and omits normalized params" do
    args = [
      "--consumer-key",
      "ck_123",
      "--consumer-secret",
      "cs_456",
      "--token",
      "at_789",
      "--secret",
      "ats_abc",
      "--nonce",
      "4d7b2e0f9a",
      "--timestamp",
      "1699999999",
      "--uri",
      "https://api.example.com/v1/xmpp",
      "--parameters",
      "foo:bar",
      "--verbose",
      "--xmpp",
    ]

    out = run_cli("sign", args)

    # In XMPP mode, normalized params line is suppressed
    expect(out).not_to include("Normalized params:")

    expect(out).to include("Signature base string:")
    expect(out).to include("XMPP Stanza:")
    expect(out).to include("<oauth xmlns='urn:xmpp:oauth:0'>")
    expect(out).to include("Note: You may want to use bare JIDs in your URI.")

    # Still prints signature summaries
    expect(out).to include("Signature:")
    expect(out).to include("Escaped signature:")
  end
end
