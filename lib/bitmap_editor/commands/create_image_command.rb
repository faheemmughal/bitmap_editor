# frozen_string_literal: true

module BitmapEditor
  class CreateImageCommand
    # Command: I M N

    # #parse
    # line is passed in as parameter
    # if parsing succeeds, we return the parased parameters
    # otherwise, we return nil
    def parse(line)
      return unless line =~ /^I\s+(\d+)\s+(\d+)$/

      columns = Regexp.last_match(1).to_i
      rows = Regexp.last_match(2).to_i

      { columns: columns, rows: rows }
    end

    # #execute
    # image is always the first parameter, whether its present or not
    # rest of the parameters are result of parsing
    # This method is expected to return image object
    def execute(image:, columns:, rows:)
      create_image(columns, rows)
    end

    private

    def create_image(columns, rows)
      unless valid_parameters_for_create?(columns, rows)
        Log.instance.error "Can not create image of size #{columns}, #{rows}"
        return
      end

      # intialise to all white
      Image.new(columns, rows)
    end

    def valid_parameters_for_create?(columns, rows)
      columns.between?(Image::MIN_COLUMNS, Image::MAX_COLUMNS) &&
        rows.between?(Image::MIN_ROWS, Image::MAX_ROWS)
    end
  end
end
