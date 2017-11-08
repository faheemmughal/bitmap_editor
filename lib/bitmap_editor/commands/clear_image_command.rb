# frozen_string_literal: true

module BitmapEditor
  class ClearImageCommand
    # Command:  C

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^C$/

      # success
      {}
    end

    # #run
    # image is always the first parameter, whether its present or not
    # rest of the parameters are result of parsing
    # This method is expected to return image object
    def run(image:)
      unless image
        Log.instance.error 'There is no image present'
        return
      end

      image.clear
      image
    end
  end
end
