# frozen_string_literal: true

module BitmapEditor
  class CommandRunner
    MIN_COLUMNS = MIN_ROWS = 1
    MAX_COLUMNS = MAX_ROWS = 255

    def execute(command)
      case command
      when /^I (\d+) (\d+)$/
        columns = Regexp.last_match(1).to_i
        rows = Regexp.last_match(2).to_i
        create_image(columns, rows)
      when 'S'
        print_image
      else
        Log.instance.error "unrecognised command: #{command}"
      end
    end

    private

    attr_accessor :image

    def create_image(columns, rows)
      unless valid_parameters_for_create?(columns, rows)
        Log.instance.error "Can not create image of size #{columns}, #{rows}"
        return
      end

      # intialise to all white
      self.image = Image.new(columns, rows)
    end

    def print_image
      return Log.instance.error 'There is no image present' unless image

      output = +''
      image.rows.times do |y|
        image.columns.times do |x|
          output << image.pixel_at(x, y)
        end
        output << "\n"
      end
      puts output
    end

    def valid_parameters_for_create?(columns, rows)
      columns.between?(MIN_COLUMNS, MAX_COLUMNS) &&
        rows.between?(MIN_ROWS, MAX_ROWS)
    end
  end
end
