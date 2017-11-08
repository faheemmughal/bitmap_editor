# frozen_string_literal: true

module BitmapEditor
  class CommandRunner
    def initialize
      @commands = [
        ClearImageCommand.new,
        ColourPixelCommand.new,
        CreateImageCommand.new,
        DrawHorizontalLineCommand.new,
        DrawVerticalLineCommand.new,
        PrintImageCommand.new
      ]
    end

    def execute(line)
      # executes first successfully parsed command
      success = commands.find do |command|
        parameters = command.parse(line)
        next unless parameters

        self.image = command.execute(parameters.merge(image: image))
        true
      end

      Log.instance.error "unrecognised command: #{line}" unless success
    end

    private

    attr_accessor :image, :commands
  end
end
