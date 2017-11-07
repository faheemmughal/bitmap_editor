# frozen_string_literal: true

require 'bitmap_editor/command_runner'
require 'bitmap_editor/image'

module BitmapEditor
  def self.run(file)
    return puts 'please provide correct file' if file.nil? || !File.exists?(file)

    runner = CommandRunner.new
    File.open(file).each do |line|
      runner.execute(line.chomp)
    end
  end
end
