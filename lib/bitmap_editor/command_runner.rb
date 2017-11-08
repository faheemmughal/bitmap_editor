# frozen_string_literal: true

module BitmapEditor
  class CommandRunner

    def execute(command)
      case command
      when /^I\s+(\d+)\s+(\d+)$/ # I M N
        columns = Regexp.last_match(1).to_i
        rows = Regexp.last_match(2).to_i
        create_image(columns, rows)
      when /^L\s+(\d+)\s+(\d+)\s+([A-Z])$/ # L X Y C
        x = Regexp.last_match(1).to_i
        y = Regexp.last_match(2).to_i
        colour = Regexp.last_match(3)
        colour_pixel(x, y, colour)
      when 'C'
        clear_image
      when 'S'
        print_image
      else
        Log.instance.error "unrecognised command: #{command}"
        # do nothing
      end
    end

    private

    attr_accessor :image

    def clear_image
      return Log.instance.error 'There is no image present' unless image

      image.clear
    end

    def create_image(columns, rows)
      unless valid_parameters_for_create?(columns, rows)
        Log.instance.error "Can not create image of size #{columns}, #{rows}"
        return
      end

      # intialise to all white
      self.image = Image.new(columns, rows)
    end

    def colour_pixel(x, y, colour)
      return Log.instance.error 'There is no image present' unless image

      image.colour(x, y, colour)
    end

    def print_image
      return Log.instance.error 'There is no image present' unless image

      puts image.to_s
    end

    def valid_parameters_for_create?(columns, rows)
      columns.between?(Image::MIN_COLUMNS, Image::MAX_COLUMNS) &&
        rows.between?(Image::MIN_ROWS, Image::MAX_ROWS)
    end
  end
end
