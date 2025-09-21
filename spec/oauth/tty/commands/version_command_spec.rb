# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::VersionCommand, :check_output do
  let(:stdout) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:stderr) { StringIO.new }

  def run_cli(command, argv = [])
    cli = OAuth::TTY::CLI.new(stdout, stdin, stderr, command, argv.dup)
    cli.run
    stdout.rewind
    out = stdout.read
    stdout.truncate(0)
    stdout.rewind
    out
  end

  it "prints versions for oauth and oauth-tty gems" do
    out = run_cli("version")

    expect(out).to include("OAuth Gem #{OAuth::Version::VERSION}")
    expect(out).to include("OAuth TTY Gem #{OAuth::TTY::Version::VERSION}")

    # no errors expected
    expect(stderr.string).to eq("")
  end
end
