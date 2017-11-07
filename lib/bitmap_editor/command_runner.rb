# frozen_string_literal: true

module BitmapEditor
  class CommandRunner
    MIN_COLUMNS = MIN_ROWS = 1
    MAX_COLUMNS = MAX_ROWS = 255

    def execute(command)
      case command
      when /^I/
        parameter_hash = parse_for_create_image(command)
        create_image(parameter_hash) if parameter_hash
      when 'S'
        print_image
      else
        puts 'unrecognised command :('
      end
    end

    private

    attr_accessor :image

    def parse_for_create_image(command)
      parameters = command.split(' ')
      return puts 'incorrect parameter size for create image command :(' if parameters.size != 3

      _command, columns, rows = parameters

      { columns: Integer(columns, 10), rows: Integer(rows, 10) }
    rescue ArgumentError
      return puts 'incorrect parameter size for create image command :('
    end

    def create_image(columns:, rows:)
      unless valid_parameters_for_create?(columns, rows)
        puts "Can not create image of size #{columns}, #{rows}"
        return
      end

      # intialise to all white
      self.image = Image.new(columns, rows)
    end

    def print_image
      return puts 'There is no image' unless image

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
