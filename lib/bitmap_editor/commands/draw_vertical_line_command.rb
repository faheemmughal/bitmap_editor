# frozen_string_literal: true

module BitmapEditor
  class DrawVerticalLineCommand
    # Command: V X Y1 Y2 C
    # Draw a vertical segment of colour C in column X
    # between rows Y1 and Y2 (inclusive).

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^V\s+(\d+)\s+(\d+)\s+(\d+)\s+([A-Z])$/

      x = Regexp.last_match(1).to_i
      y1 = Regexp.last_match(2).to_i
      y2 = Regexp.last_match(3).to_i
      colour = Regexp.last_match(4)
      { x: x, y1: y1, y2: y2, colour: colour }
    end

    # #execute
    # image is always passed, whether its present or not
    # rest of the parameters are result of parsing
    # This method is expected to return an image object
    def execute(image:, x:, y1:, y2:, colour:)
      unless image
        Log.instance.error 'There is no image present'
        return
      end

      image.draw_vertical(x, y1, y2, colour)
      image
    end
  end
end
