# frozen_string_literal: true

require 'bitmap_editor/command_runner'
require 'bitmap_editor/image'
require 'bitmap_editor/log'
require 'bitmap_editor/commands/clear_image_command'
require 'bitmap_editor/commands/colour_pixel_command'
require 'bitmap_editor/commands/create_image_command'
require 'bitmap_editor/commands/draw_vertical_line_command'
require 'bitmap_editor/commands/print_image_command'

module BitmapEditor
  def self.run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    runner = CommandRunner.new
    File.open(file).each do |line|
      runner.execute(line.chomp)
    end
  end
end
