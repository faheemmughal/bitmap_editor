# frozen_string_literal: true


module BitmapEditor
  class CommandRunner

    def initialize
      @commands = [
        ClearImageCommand.new,
        ColourImageCommand.new,
        CreateImageCommand.new,
        PrintImageCommand.new
      ]
    end

    def execute(line)
      # executes first parsed command
      success = commands.find do |command|
        parameters = command.parse(line)
        next unless parameters

        self.image = command.run(parameters.merge(image: image))
        true
      end

      Log.instance.error "unrecognised command: #{line}" unless success
    end

    private

    attr_accessor :image, :commands
  end
end
