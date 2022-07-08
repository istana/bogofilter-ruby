# frozen_string_literal: true

require "open3"
require "terrapin"
require_relative "bogofilter/version"

class Bogofilter
  class Error < StandardError; end

  def self.configuration
    run("-Q")
  end

  def self.version
    result = run("-V")
    version_match = result.match(%r{bogofilter version (\d+\.\d+\.\d+)})

    if version_match
      version_match[1]
    else
      raise Error.new('cannot detect bogofilter version')
    end
  end

  def self.run(arguments, stdin: nil, params: {}, verbosity:)
    verbosity_args = verbosity > 0 ? "-D -#{'v' * verbosity}" : ""
    line = Terrapin::CommandLine.new("bogofilter", "-C -e #{verbosity_args} #{arguments}")
    command = line.command(params)

    stdout, status = Open3.capture2(command, stdin_data: stdin)

    if verbosity > 0
      $stdout.puts stdout
    end

    raise Error.new("command failed with #{status}") if status != 0

    [stdout, status]
  end

  def initialize(dbpath:, verbosity: 0)
    @dbpath = dbpath
    @verbosity = verbosity

    raise Error.new('verbosity can be between 0-4') if !(0..4).cover?(verbosity)
  end

  def run(arguments, stdin: nil, params: {})
    self.class.run("-d :dbpath #{arguments}",
      params: params.merge({ dbpath: @dbpath }),
      stdin: stdin,
      verbosity: @verbosity,
    )
  end

  def add_spam(text)
    _stdout, status = run("-s", stdin: text)
    status == 0
  end

  def remove_spam(text)
    _stdout, status = run("-S", stdin: text)
    status == 0
  end

  def add_ham(text)
    _stdout, status = run("-n", stdin: text)
    status == 0
  end

  def remove_ham(text)
    _stdout, status = run("-N", stdin: text)
    status == 0
  end

  def classify(text)
    stdout, _status = run("-T", stdin: text)
    classification, score = stdout.split(" ", 2)
    mapping = {
      "H" => :ham,
      "S" => :spam,
      "U" => :unsure,
    }

    {
      result: mapping[classification],
      score: score.to_f,
    }
  end

  def is_spam?(text)
    classification = classify(text)
    return nil if classification[:result] == :unsure
    classification[:result] == :spam
  end

  def is_ham?(text)
    classification = classify(text)
    return nil if classification[:result] == :unsure
    classification[:result] == :ham
  end
end
