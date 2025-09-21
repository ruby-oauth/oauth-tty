# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::QueryCommand, :check_output do
  let(:stdout) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  def run_cli(command, argv)
    cli = OAuth::TTY::CLI.new(stdout, stdin, stderr, command, argv.dup)
    cli.run
    stdout.rewind
    out = stdout.read
    stdout.truncate(0)
    stdout.rewind
    out
  end

  it "appends parameters to the URI, performs the request, and prints status and body" do
    # Stub network objects so we don't make real HTTP calls
    consumer = instance_double("OAuth::Consumer")
    allow(OAuth::Consumer).to receive(:new).and_return(consumer)

    access_token = instance_double("OAuth::AccessToken")
    allow(OAuth::AccessToken).to receive(:new).with(consumer, "at_789", "ats_abc").and_return(access_token)

    fake_response = instance_double("Net::HTTPResponse", code: "200", message: "OK", body: "Hello world")

    # Build args
    uri = "https://api.example.com/v1/profile"
    argv = [
      "--consumer-key",
      "ck_123",
      "--consumer-secret",
      "cs_456",
      "--token",
      "at_789",
      "--secret",
      "ats_abc",
      "--method",
      "GET",
      "--nonce",
      "abc123",
      "--timestamp",
      "1699999999",
      "--uri",
      uri,
      "--parameters",
      "foo:bar",
      "--parameters",
      "status=active",
    ]

    expected_url = "#{uri}?oauth_consumer_key=ck_123&oauth_nonce=abc123&oauth_timestamp=1699999999&oauth_token=at_789&oauth_signature_method=HMAC-SHA1&oauth_version=1.0&foo=bar&status=active"

    expect(access_token).to receive(:request).with(:get, expected_url).and_return(fake_response)

    out = run_cli("query", argv)

    # First line prints the final URL used
    # Second line prints status line
    # Third line prints response body
    expect(out).to include(expected_url)
    expect(out).to include("200 OK")
    expect(out).to include("Hello world")

    # no errors expected
    expect(stderr.string).to eq("")
  end
end
