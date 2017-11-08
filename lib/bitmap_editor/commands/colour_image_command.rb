# frozen_string_literal: true

module BitmapEditor
  class ColourImageCommand
    # Command:  L X Y C

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^L\s+(\d+)\s+(\d+)\s+([A-Z])$/

      x = Regexp.last_match(1).to_i
      y = Regexp.last_match(2).to_i
      colour = Regexp.last_match(3)
      { x: x, y: y, colour: colour }
    end

    # #execute
    # image is always passed, whether it is present or not
    # rest of the parameters are result of parsing
    # This method is expected to return an image object
    def execute(image:, x:, y:, colour:)
      unless image
        Log.instance.error 'There is no image present'
        return
      end

      image.colour(x, y, colour)
      image
    end
  end
end
