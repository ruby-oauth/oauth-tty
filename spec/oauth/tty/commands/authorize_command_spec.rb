# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::AuthorizeCommand do
  let(:stdout) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  def build_cmd(args = [])
    described_class.new(stdout, stdin, stderr, args)
  end

  describe "#_run happy path with callback confirmed", :check_output do
    it "sets version to 1.0a and prompts for verifier, then prints response params" do
      consumer = instance_double(OAuth::Consumer)
      request_token = instance_double(OAuth::RequestToken)
      access_token = instance_double(OAuth::AccessToken, params: {"oauth_token" => "OTK", :symbol_key => "ignored"})

      # Provide deterministic nonce/timestamp used by defaults through Command
      allow(OAuth::Helper).to receive_messages(generate_key: "KEY", generate_timestamp: "TS")

      allow(OAuth::Consumer).to receive(:new).and_return(consumer)
      allow(consumer).to receive(:get_request_token).with({oauth_callback: nil}, {}).and_return(request_token)

      allow(request_token).to receive_messages(callback_confirmed?: true, authorize_url: "https://example.com/authorize")

      # stdin provides a verifier when version is 1.0a
      stdin.write("VERIFIER\n")
      stdin.rewind

      allow(request_token).to receive(:get_access_token).with({oauth_verifier: "VERIFIER"}).and_return(access_token)

      stdout.string.dup
      build_cmd(%w[--consumer-key CK --consumer-secret CS --method GET --uri https://example.com]).run

      stdout.rewind
      out = stdout.read
      expect(out).to include("Server appears to support OAuth 1.0a; enabling support.")
      expect(out).to include("Please visit this url to authorize:")
      expect(out).to include("https://example.com/authorize")
      expect(out).to include("Please enter the verification code provided by the SP (oauth_verifier):")
      expect(out).to include("Response:")
      # Only non-symbol keys are printed
      expect(out).to include("  oauth_token: OTK")
      expect(out).not_to include("symbol_key")
    end
  end

  describe "error handling", :check_output do
    it "alerts when get_request_token raises OAuth::Unauthorized" do
      consumer = instance_double(OAuth::Consumer)

      allow(OAuth::Consumer).to receive(:new).and_return(consumer)
      request_class = Struct.new(:body, :code, :message)
      error = OAuth::Unauthorized.new(request_class.new("denied", 401, "401 Unauthorized"))
      allow(consumer).to receive(:get_request_token).and_raise(error)

      build_cmd(%w[--consumer-key CK --consumer-secret CS --uri https://example.com]).send(:get_request_token)

      stderr.rewind
      err = stderr.read
      expect(err).to include("A problem occurred while attempting to authorize:")
      expect(err).to include("denied")
    end

    it "alerts when get_access_token raises OAuth::Unauthorized" do
      consumer = instance_double(OAuth::Consumer)
      request_token = instance_double(OAuth::RequestToken)
      allow(OAuth::Consumer).to receive(:new).and_return(consumer)
      allow(consumer).to receive(:get_request_token).and_return(request_token)

      request_class = Struct.new(:body, :code, :message)
      error = OAuth::Unauthorized.new(request_class.new("bad_access", 401, "401 Unauthorized"))
      allow(request_token).to receive_messages(callback_confirmed?: false, authorize_url: "https://example.com/authorize")
      allow(request_token).to receive(:get_access_token).and_raise(error)

      build_cmd(%w[--consumer-key CK --consumer-secret CS --uri https://example.com]).run

      stderr.rewind
      err = stderr.read
      expect(err).to include("A problem occurred while attempting to obtain an access token:")
      expect(err).to include("bad_access")
    end
  end
end
