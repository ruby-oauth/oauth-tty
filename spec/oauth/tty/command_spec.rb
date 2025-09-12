# frozen_string_literal: true

RSpec.describe OAuth::TTY::Command do
  let(:stdout) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  # Minimal concrete subclass to enable exercising #run paths
  class TestCommand < described_class
    attr_writer :required

    def initialize(stdout, stdin, stderr, arguments)
      super
      @required ||= []
    end

    def required_options
      @required
    end

    def _run
      puts "ran" # use provided stdout
    end
  end

  def build_cmd(args = [])
    TestCommand.new(stdout, stdin, stderr, args)
  end

  describe "#run", :check_output do
    it "executes _run when required options are present" do
      cmd = build_cmd(["--consumer-key", "ck"])
      cmd.required = [:oauth_consumer_key]
      out_before = stdout.string.dup
      cmd.run
      stdout.rewind
      expect(stdout.read).to eq(out_before + "ran\n")
    end

    it "prints missing options and help when required options are absent" do
      cmd = build_cmd([])
      cmd.required = [:oauth_consumer_key]

      expect(OAuth::TTY::CLI).to receive(:puts_red).with("Options missing to OAuth CLI: --oauth_consumer_key")
      cmd.run
      stdout.rewind
      expect(stdout.read).to match(/Usage: oauth <command> \[ARGS\]/)
    end
  end

  describe "option parser defaults and flags" do
    it "sets sane defaults" do
      cmd = build_cmd([])
      expect(cmd.send(:options)).to include(
        oauth_signature_method: "HMAC-SHA1",
        oauth_version: "1.0",
        scheme: :header,
        method: :post,
        params: [],
        version: "1.0",
      )
      # Non-deterministic values are present but not asserted for exact value
      expect(cmd.send(:options)).to include(:oauth_nonce, :oauth_timestamp)
    end

    it "switches scheme based on -B/--body, -H/--header, -Q/--query-string" do
      expect(build_cmd(["-B"]).send(:options)[:scheme]).to eq(:body)
      expect(build_cmd(["-H"]).send(:options)[:scheme]).to eq(:header)
      expect(build_cmd(["-Q"]).send(:options)[:scheme]).to eq(:query_string)
    end

    it "captures verbosity and xmpp flags" do
      expect(build_cmd(["--verbose"]).send(:options)[:verbose]).to be true
      expect(build_cmd(["--xmpp"]).send(:options)).to include(xmpp: true)
      # Exercise predicate helpers
      cmd = build_cmd(["--xmpp", "--verbose"])
      expect(cmd.send(:xmpp?)).to be true
      expect(cmd.send(:verbose?)).to be true
    end

    it "collects sign/query related switches" do
      cmd = build_cmd(%w[
        --method
        GET
        --nonce
        N
        --parameters
        a:1
        --parameters
        raw_pair
        --signature-method
        PLAINTEXT
        --token
        T
        --secret
        S
        --timestamp
        TS
        --realm
        R
        --uri
        http://example.com/
        --version
        1.0a
      ])
      expect(cmd.send(:options)).to include(
        method: "GET",
        oauth_nonce: "N",
        oauth_signature_method: "PLAINTEXT",
        oauth_token: "T",
        oauth_token_secret: "S",
        oauth_timestamp: "TS",
        realm: "R",
        uri: "http://example.com/",
        oauth_version: "1.0a",
      )
      expect(cmd.send(:options)[:params]).to eq(["a:1", "raw_pair"])
    end

    it "honors --no-version by nulling oauth_version" do
      cmd = build_cmd(["--no-version"])
      expect(cmd.send(:options)[:oauth_version]).to be_nil
    end

    it "captures authorization URLs and scope" do
      cmd = build_cmd(%w[
        --access-token-url
        https://example.com/access
        --authorize-url
        https://example.com/auth
        --callback-url
        https://example.com/cb
        --request-token-url
        https://example.com/request
        --scope
        email
      ])
      expect(cmd.send(:options)).to include(
        access_token_url: "https://example.com/access",
        authorize_url: "https://example.com/auth",
        oauth_callback: "https://example.com/cb",
        request_token_url: "https://example.com/request",
        scope: "email",
      )
    end
  end

  describe "#parameters" do
    it "builds escaped params and merges oauth keys, dropping nil/empty ones" do
      cmd = build_cmd(%w[
        --consumer-key
        CK
        --token
        TK
        --parameters
        foo:bar
        --parameters
        baz:qux
        --parameters
        raw=pair
      ])
      params = cmd.send(:parameters)
      # CGI.parse returns arrays of values per key
      expect(params["foo"]).to eq(["bar"]) # escaped colon-pair
      expect(params["baz"]).to eq(["qux"]) # escaped colon-pair
      expect(params["raw"]).to eq(["pair"]) # raw pair preserved
      # OAuth fields present
      expect(params).to include(
        "oauth_consumer_key" => "CK",
        "oauth_token" => "TK",
        "oauth_signature_method" => "HMAC-SHA1",
      )
      # timestamp, nonce exist but are not asserted exactly
      expect(params).to include("oauth_timestamp", "oauth_nonce")
    end
  end

  describe "output helpers", :check_output do
    it "writes to stdout and stderr" do
      cmd = build_cmd([])
      cmd.send(:puts, "out!")
      cmd.send(:alert, "err!")
      stdout.rewind
      stderr.rewind
      expect(stdout.read).to eq("out!\n")
      expect(stderr.read).to eq("err!\n")
    end
  end
end
