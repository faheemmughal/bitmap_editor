# frozen_string_literal: true

module BitmapEditor
  class ClearImageCommand
    # Command:  C
    # Clears the table, setting all pixels to white (O)

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^C$/

      # success
      {}
    end

    # #execute
    # image is always passed, whether it is present or not
    # rest of the parameters are result of parsing
    # This method is expected to return an image object
    def execute(image:)
      unless image
        Log.instance.error 'There is no image present'
        return
      end

      image.clear
      image
    end
  end
end
