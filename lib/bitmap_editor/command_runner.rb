# frozen_string_literal: true

module BitmapEditor
  class CommandRunner
    def execute(command)
      case command
      when /^I/
        create_image(command)
      when 'S'
        print_image
      else
        puts 'unrecognised command :('
      end
    end

    private

    attr_accessor :image

    def create_image(line)
      _command, columns, rows = line.split(' ')
      columns = columns.to_i
      rows = rows.to_i
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
  end
end
