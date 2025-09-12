# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::SignCommand do
  let(:stdout) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  def build_cmd(args = [])
    described_class.new(stdout, stdin, stderr, args)
  end

  describe "non-verbose output", :check_output do
    it "prints only the signature" do
      request = double(
        "Request",
        oauth_parameters: {},
        non_oauth_parameters: {},
        oauth_signature: "SIG",
      )

      expect(OAuth::RequestProxy).to receive(:proxy).and_return(request)
      expect(request).to receive(:sign!).with(consumer_secret: "CS", token_secret: "TS")

      build_cmd(%w[
        --consumer-key
        CK
        --consumer-secret
        CS
        --token
        TK
        --secret
        TS
        --uri
        https://example.com
      ]).run

      stdout.rewind
      expect(stdout.read).to eq("SIG\n")
    end
  end

  describe "verbose output with xmpp", :check_output do
    it "prints detailed information and an XMPP stanza" do
      request = double(
        "Request",
        oauth_parameters: {
          "oauth_consumer_key" => "CK",
          "oauth_token" => "TK",
          "oauth_signature_method" => "HMAC-SHA1",
          "oauth_timestamp" => "TS",
          "oauth_nonce" => "NONCE",
          "oauth_version" => "1.0",
        },
        non_oauth_parameters: {},
        method: "POST",
        uri: "https://example.com",
        normalized_parameters: "a=1&b=2",
        signature_base_string: "BASE",
        oauth_signature: "SIG",
        oauth_consumer_key: "CK",
        oauth_token: "TK",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "TS",
        oauth_nonce: "NONCE",
        oauth_version: "1.0",
      )

      # Stub out silent verbose interactions with OAuth::Consumer
      consumer = instance_double("OAuth::Consumer")
      req_token = instance_double("OAuth::RequestToken")
      expect(OAuth::Consumer).to receive(:new).and_return(consumer)
      expect(consumer).to receive(:get_request_token).and_return(req_token)
      allow(req_token).to receive(:callback_confirmed?).and_return(false)
      allow(req_token).to receive(:authorize_url).and_return("https://example.com/authorize")
      allow(req_token).to receive(:get_access_token).and_return(instance_double("AccessToken"))

      expect(OAuth::RequestProxy).to receive(:proxy).and_return(request)
      expect(request).to receive(:sign!).with(consumer_secret: "CS", token_secret: "TS")

      build_cmd(%w[
        --consumer-key
        CK
        --consumer-secret
        CS
        --token
        TK
        --secret
        TS
        --uri
        https://example.com
        --verbose
        --xmpp
      ]).run

      stdout.rewind
      out = stdout.read
      expect(out).to include("OAuth parameters:")
      expect(out).to include("XMPP Stanza:")
      expect(out).to include("<oauth_consumer_key>CK</oauth_consumer_key>")
      expect(out).to include("Escaped signature: ")
      # In XMPP mode, it should not print normalized params line
      expect(out).not_to include("Normalized params:")
    end
  end
end
