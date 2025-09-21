# frozen_string_literal: true

RSpec.describe OAuth::TTY::Commands::HelpCommand, :check_output do
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

  it "prints usage and lists available commands" do
    out = run_cli("help", [])

    expect(out).to include("Usage: oauth COMMAND")
    expect(out).to include("authorize")
    expect(out).to include("query")
    expect(out).to include("sign")
    expect(out).to include("version")
    expect(out).to include("help")

    # no errors expected
    expect(stderr.string).to eq("")
  end
end
