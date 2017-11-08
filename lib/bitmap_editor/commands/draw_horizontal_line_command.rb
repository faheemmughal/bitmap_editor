# frozen_string_literal: true

module BitmapEditor
  class DrawHorizontalLineCommand
    # Command: H X1 X2 Y C
    # Draw a horizontal segment of colour C in row Y between
    # columns X1 and X2 (inclusive).

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^H\s+(\d+)\s+(\d+)\s+(\d+)\s+([A-Z])$/

      x1 = Regexp.last_match(1).to_i
      x2 = Regexp.last_match(2).to_i
      y = Regexp.last_match(3).to_i
      colour = Regexp.last_match(4)
      { x1: x1, x2: x2, y: y, colour: colour }
    end

    # #execute
    # image is always passed, whether its present or not
    # rest of the parameters are result of parsing
    # This method is expected to return an image object
    def execute(image:, x1:, x2:, y:, colour:)
      unless image
        Log.instance.error 'There is no image present'
        return
      end

      image.draw_horizontal(x1, x2, y, colour)
      image
    end
  end
end
